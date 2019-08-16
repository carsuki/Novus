//
//  RepositoriesController.m
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "RepositoriesController.h"

@interface RepositoriesController ()

@end

@implementation RepositoriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.sources = [[NSMutableArray alloc] init];
    [self grabSourcesInLists];
    [self grabFilenames];
    [self parseRepos];
}

-(void)grabSourcesInLists {
    self.sourcesInList = [[NSMutableArray alloc] init];
    
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
        if(![repoDirectory isEqualToString:@"./"]) {
            NSArray *repoComponents = [repoDirectory componentsSeparatedByString:@" "];
            NSString *releaseURL = [NSString stringWithFormat:@"%@/dists/%@/Release",repoURL,[repoComponents objectAtIndex:0]];
            repo.releaseURL = releaseURL;
            repo.releasePath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[releaseURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
            NSString *packagesURL = [NSString stringWithFormat:@"%@/dists/%@/%@/binary-darwin-amd64/Packages",repoURL,[repoComponents objectAtIndex:0],[repoComponents objectAtIndex:1]];
            repo.packagesURL = packagesURL;
            repo.packagesPath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[packagesURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
            NSLog(@"\n%@", repo.packagesPath);
            NSLog(@"\n%@", repo.releasePath);
        } else {
            repoURL = [repoURL stringByAppendingString:repoDirectory];
            repo.releaseURL = [NSString stringWithFormat:@"%@Release", repoURL];
            repo.releasePath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[repo.releaseURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
            repo.packagesURL = [NSString stringWithFormat:@"%@Packages", repoURL];
            repo.packagesPath = [NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", [[repo.packagesURL stringByReplacingOccurrencesOfString:@"https://" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
            NSLog(@"\n%@", repo.packagesPath);
            NSLog(@"\n%@", repo.releasePath);
        }
        [self.sources addObject:repo];
    }];
}

-(void)parseRepos {
    [self.sources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSRepo *repo = obj;
        LMPackageParser *parser = [[LMPackageParser alloc] initWithFilePath:repo.packagesPath];
        repo.packages = parser.packages;
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
        }];
        [self.sources removeObjectAtIndex:idx];
        [self.sources insertObject:repo atIndex:idx];
    }];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.sourcesInList.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSRepo *repo = [self.sources objectAtIndex:row];
    return [NSString stringWithFormat:@"%@, Packages: %ld", repo.label, (long)repo.packages.count];
}

-(BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    [self performSegueWithIdentifier:@"browseRepo" sender:self];
    return NO;
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    NVSRepo *repo = [self.sources objectAtIndex:self.tableView.selectedRow];
    BrowseRepoController *destController = segue.destinationController;
    destController.repo = repo;
}

@end
