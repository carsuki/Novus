//
//  NVSPackageManager.m
//  Novus
//
//  Created by EvenDev on 04/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSPackageManager.h"

@implementation NVSPackageManager

+ (id)sharedInstance {
    static NVSPackageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

-(id)init {
    self = [super init];
    if (self) {
        self.packagesArray = [NSMutableArray new];
        self.packagesDict = [NSMutableDictionary new];
        self.installedPackagesArray = [NSMutableArray new];
        self.installedPackagesDict = [NSMutableDictionary new];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.sources = [[NSMutableArray alloc] init];
        self.sourcesInList = [[NSMutableArray alloc] init];
        [self.dateFormatter setDateFormat:@"E, d MMM yyyy HH:mm:ss Z"];
        [self getInstalledPackages];
        [self grabSourcesInLists];
        [self grabFilenames];
        [self parseRepos];
    }
    return self;
}

-(void)getInstalledPackages {
    LMPackageParser *parser = [[LMPackageParser alloc] initWithFilePath:@"/usr/local/var/lib/dpkg/status"];
    [parser.packages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSPackage *pkg = obj;
        if ([NSImage imageNamed:[pkg.section stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[pkg.section substringToIndex:1] uppercaseString]]]) {
            pkg.icon = [NSImage imageNamed:[pkg.section stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[pkg.section substringToIndex:1] uppercaseString]]];
        } else {
            pkg.icon = [NSImage imageNamed:@"Unknown"];
        }
        [self.installedPackagesDict setObject:pkg forKey:pkg.identifier];
        [self.packagesDict setObject:pkg forKey:pkg.identifier];
    }];
}

-(void)grabSourcesInLists {
    // /usr/local/etc/apt/SOURCES.LIST
    NSMutableArray *sourcesListLines = [NSMutableArray arrayWithArray:[[NSString stringWithContentsOfFile:@"/usr/local/etc/apt/sources.list" encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    
    [sourcesListLines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *line = obj;
        if (line.length > 4 && [line containsString:@"deb"]) {
            [self.sourcesInList addObject:line];
        }
    }];
    
    // /usr/local/etc/apt/sources.list.d/NOVUS.LIST
    NSMutableArray *novusListLines = [NSMutableArray arrayWithArray:[[NSString stringWithContentsOfFile:@"/usr/local/etc/apt/sources.list.d/NOVUS.LIST" encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    
    [novusListLines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *line = obj;
        if (line.length > 4 && [line containsString:@"deb"]) {
            [self.sourcesInList addObject:line];
        }
    }];
}

-(void)grabFilenames {
    [self.sourcesInList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSRepo *repo = [[NVSRepo alloc] init];
        NSString *fileLine = obj;
        NSString *strippedFileLine = [fileLine substringFromIndex:4]; // removes "deb "
        // i separate the string into two parts: "https://an.example.repourl/" and "./" (or some kinda "stable main" like bigboss and modmyi do)
        NSInteger locationOfSpace = [strippedFileLine rangeOfString:@" "].location;
        // the actual url
        NSString *repoURL = [strippedFileLine substringToIndex:locationOfSpace];
        // either the "./" or "stable main" etc at the end
        NSString *repoDirectory = [strippedFileLine substringFromIndex:locationOfSpace + 1];
        repo.repoDirectory = repoDirectory;
        repo.repoURL = repoURL;
        if(![repoDirectory isEqualToString:@"./"]) {
            if ([[repoURL substringFromIndex:[repoURL length] - 1] isEqualToString:@"/"]) {
                repoURL = [repoURL substringToIndex:repoURL.length - 1];
            }
            NSArray *repoComponents = [repoDirectory componentsSeparatedByString:@" "];
            repo.repoComponents = repoComponents;
            NSString *releaseURL = [NSString stringWithFormat:@"%@/dists/%@/Release",repoURL,[repoComponents objectAtIndex:0]];
            repo.releaseURL = releaseURL;
            repo.releasePath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[releaseURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
            NSString *packagesURL = [NSString stringWithFormat:@"%@/dists/%@/%@/binary-darwin-amd64/Packages",repoURL,[repoComponents objectAtIndex:0],[repoComponents objectAtIndex:1]];
            repo.packagesURL = packagesURL;
            repo.packagesPath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[packagesURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
        } else {
            if (![[repoURL substringFromIndex:[repoURL length] - 1] isEqualToString:@"/"]) {
                repoURL = [repoURL stringByAppendingString:@"/"];
            }
            repoURL = [repoURL stringByAppendingString:repoDirectory];
            repo.releaseURL = [NSString stringWithFormat:@"%@Release", repoURL];
            repo.releasePath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[repo.releaseURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
            repo.packagesURL = [NSString stringWithFormat:@"%@Packages", repoURL];
            repo.packagesPath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[repo.packagesURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
        }
        if ([[NSFileManager defaultManager] fileExistsAtPath:repo.releasePath] && [[NSFileManager defaultManager] fileExistsAtPath:repo.packagesPath]) {
            [self.sources addObject:repo];
        } else {
            NSLog(@"Failed to add %@, does not exist.", repo.releasePath);
        }
    }];
    NSLog(@"Got %ld repositories", (long)self.sources.count);
}

-(void)parseRepos {
    [self.sources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSRepo *repo = obj;
        LMPackageParser *parser = [[LMPackageParser alloc] initWithFilePath:repo.packagesPath];
        NSMutableArray *releaseFileLines = [NSMutableArray arrayWithArray:[[NSString stringWithContentsOfFile:repo.releasePath encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
        [releaseFileLines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj containsString:@"Origin:"]) {
                repo.origin = [[[obj componentsSeparatedByString:@"Origin: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Label:"]) {
                repo.label = [[[obj componentsSeparatedByString:@"Label: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Suite:"]) {
                repo.suite = [[[obj componentsSeparatedByString:@"Suite: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Version:"]) {
                repo.version = [[[obj componentsSeparatedByString:@"Version: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Codename:"]) {
                repo.codename = [[[obj componentsSeparatedByString:@"Codename: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Architectures:"]) {
                repo.architectures = [[[obj componentsSeparatedByString:@"Architectures: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Components:"]) {
                repo.components = [[[obj componentsSeparatedByString:@"Components: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Description:"]) {
                repo.desc = [[[obj componentsSeparatedByString:@"Description: "] mutableCopy] objectAtIndex:1];
            }
            if ([obj containsString:@"Date:"]) {
                repo.lastUpdated = [self.dateFormatter dateFromString:[[[obj componentsSeparatedByString:@"Date: "] mutableCopy] objectAtIndex:1]];
            }
        }];
        // Add repo to packages
        [parser.packages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NVSPackage *pkg = obj;
            pkg.repository = repo;
            if ([NSImage imageNamed:[pkg.section stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[pkg.section substringToIndex:1] uppercaseString]]]) {
                pkg.icon = [NSImage imageNamed:[pkg.section stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[pkg.section substringToIndex:1] uppercaseString]]];
            } else {
                pkg.icon = [NSImage imageNamed:@"Unknown"];
            }
            pkg.debURL = [NSString stringWithFormat:@"%@/%@", repo.repoURL, pkg.filename];
            if ([self.packagesDict objectForKey:pkg.identifier]) {
                pkg.installed = YES;
            }
            [self.packagesDict setObject:pkg forKey:pkg.identifier];
            [parser.packages replaceObjectAtIndex:idx withObject:pkg];
        }];
        
        // Grab repo icons
        if(![repo.repoDirectory isEqualToString:@"./"]) {
            repo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/dists/%@/%@/RepoIcon.png", repo.repoURL, [repo.repoComponents objectAtIndex:0], [repo.repoComponents objectAtIndex:1]]];
        } else {
            repo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/RepoIcon.png", repo.repoURL]];
        }
        NSString *localImagePath = [repo.releasePath stringByReplacingOccurrencesOfString:@"Release" withString:@".png"];
        NSImage *repoIcon = [[NSImage alloc] initWithContentsOfURL:repo.imageURL];
        repo.imagePath = localImagePath;
        if (repoIcon) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:localImagePath]) {
                CGImageRef cgRef = [repoIcon CGImageForProposedRect:NULL context:nil hints:nil];
                NSBitmapImageRep *newRep = [[NSBitmapImageRep alloc] initWithCGImage:cgRef];
                [newRep setSize:repoIcon.size];
                NSData *pngData = [newRep representationUsingType:NSPNGFileType properties:@{}];
                [pngData writeToFile:localImagePath atomically:YES];
                NSLog(@"did grab icon");
            }
            repo.image = repoIcon;
        }
        repo.packages = parser.packages;
        [self.sources replaceObjectAtIndex:idx withObject:repo];
    }];
    [self addPackagesFromDictToAray];
}

-(void)addPackagesFromDictToAray {
    [self.packagesDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NVSPackage *pkg = obj;
        [self.packagesArray addObject:pkg];
    }];
    [self.installedPackagesDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NVSPackage *pkg = obj;
        [self.installedPackagesArray addObject:pkg];
    }];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    self.installedPackagesArray = [NSMutableArray arrayWithArray:[[self installedPackagesArray] sortedArrayUsingDescriptors:@[sort]]];
    NSLog(@"[NVSPackageManager] Installed Packages: %ld", (long)self.installedPackagesDict.count);
    NSLog(@"[NVSPackageManager] Total Packages: %ld", (long)self.packagesDict.count);
}

-(void)refresh {
    [[NVSCommandWrapper sharedInstance] runAsRoot:@"apt-get update"];
    self.packagesArray = [NSMutableArray new];
    self.packagesDict = [NSMutableDictionary new];
    self.installedPackagesArray = [NSMutableArray new];
    self.installedPackagesDict = [NSMutableDictionary new];
    self.sources = [[NSMutableArray alloc] init];
    self.sourcesInList = [[NSMutableArray alloc] init];
    [self getInstalledPackages];
    [self grabSourcesInLists];
    [self grabFilenames];
    [self parseRepos];
}

@end
