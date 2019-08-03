//
//  LMDPKGParser.m
//  Lime
//
//  Created by EvenDev on 7/1/19.
//  Copyright © 2019 EvenDev. All rights reserved.
//
//  Special thanks to the Lime team for providing the DPKG parser files, Lime team is complety credited and their Twitter can be found here: https://twitter.com/limeinstaller.

//  Lime is a package manager for Jailbroken iOS devices.
//  Original file: LMDPKGParser.m, HEAVILY modified by EvenDev to make it work.


#import "RepoParser.h"
#import "NVSPackage.h"

@implementation RepoParser

- (NSMutableArray*)packagesFromPath:(const char *)path {
    NSMutableArray *finishedPackages = [[NSMutableArray alloc] init];
    
    NSLog(@"init repo package parser");
    
    NSMutableArray *packages = [[NSMutableArray alloc] init];
    FILE *file = fopen(path, "r");
    char str[999];
    NSString *lastDesc = @"";
    NSString *lastMaintainer = @"";
    NSString *lastVersion = @"";
    NSString *lastSize = @"";
    NSString *lastSection = @"";
    while(fgets(str, 999, file) != NULL) {
#define ProcessEntry(val, str) ([[[NSString stringWithCString:str encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@val": " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""])
#define TestEntrySet(val, var) if (strstr(str, val":")) var = ProcessEntry(val, str)
#define TestEntryAdd(val, var) if (strstr(str, val":")) [var addObject:ProcessEntry(val, str)]
        TestEntryAdd("Package", packages);
        TestEntrySet("Description", lastDesc);
        TestEntrySet("Maintainer", lastMaintainer);
        TestEntrySet("Version", lastVersion);
        TestEntrySet("Size", lastSize);
        TestEntrySet("Section", lastSection);
        if(strlen(str) < 2 && packages.count > 0) {
            NSString *lastObject = [packages lastObject];
            [packages sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            if(finishedPackages.count < packages.count) {
                NSInteger index = [packages indexOfObject:lastObject];
                
                NVSPackage *package = [NVSPackage new];
                package.identifier = [packages objectAtIndex:index];
                package.desc = lastDesc;
                package.maintainer = lastMaintainer;
                package.section = lastSection;
                package.installedSize = lastSize;
                package.version = lastVersion;
                package.section = lastSection;
                
                [finishedPackages insertObject:package atIndex:index];
                
                lastDesc = @"";
                lastMaintainer = @"";
                lastVersion = @"";
                lastSize = @"";
                lastSection = @"";
            }
        }
    }
    fclose(file);
    NSLog(@"Got %lu Packages From Repo", finishedPackages.count);
    return finishedPackages;
}

- (instancetype)init {
    self = [super init];
    self.addedRepositories = [[NSMutableArray alloc] init];
    self.tempRepo = [[NSMutableArray alloc] init];
    
    NSLog(@"init repo parser");
    
    NSMutableArray *repositories = [[NSMutableArray alloc] init];
    NSMutableArray *repositoriesFilenames = [[NSMutableArray alloc] init];
    
    NSMutableArray *contentsOfListDir = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/usr/local/var/lib/apt/lists" error:nil] mutableCopy];
    NSString *novusList = [NSString stringWithContentsOfFile:@"/usr/local/etc/apt/sources.list.d/novus.list" encoding:NSUTF8StringEncoding error:nil];
    NSString *standardNovusList = [NSString stringWithContentsOfFile:@"/usr/local/etc/apt/sources.list" encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *novusListLines = [NSMutableArray arrayWithArray:[novusList componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    NSMutableArray *standardNovusListLines = [NSMutableArray arrayWithArray:[standardNovusList componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    
    NSInteger count = [novusListLines count];
    for (NSInteger index = (count - 1); index >= 0; index--) {
        NSString *string = novusListLines[index];
        if (![string containsString:@"https://"]) {
            [novusListLines removeObjectAtIndex:index];
        }
        //NSLog(@"%@", novusListLines);
    }
    for (id object in novusListLines) {
        NSArray *strArray = [object componentsSeparatedByString:@" "];
        NSMutableArray *separatedStrings = [NSMutableArray arrayWithCapacity:[strArray count]];
        [separatedStrings addObjectsFromArray:strArray];
        //NSMutableArray *separatedStrings = (NSString*)[object componentsSeparatedByString:@" "];
        NSString *filename;
        if (![[separatedStrings objectAtIndex:1] isEqual:@"[trusted=yes]"]) {
            NSString *filenameA = [[[separatedStrings objectAtIndex:1] stringByReplacingOccurrencesOfString:@"/" withString:@"_"] stringByReplacingOccurrencesOfString:@"https:__" withString:@""];
            NSString *filenameB = [[separatedStrings objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
            filename = [NSString stringWithFormat:@"%@%@Release", filenameA, filenameB];
            [repositories addObject:(NSString*)[separatedStrings objectAtIndex:1]];
        } else {
            NSString *filenameA = [[[separatedStrings objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/" withString:@"_"] stringByReplacingOccurrencesOfString:@"https:__" withString:@""];
            NSString *filenameB = [[separatedStrings objectAtIndex:3] stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
            filename = [NSString stringWithFormat:@"%@%@Release", filenameA, filenameB];
            [repositories addObject:(NSString*)[separatedStrings objectAtIndex:2]];
        }
        [repositoriesFilenames addObject:[NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", filename]];
    }
    for (id object in standardNovusListLines) {
        NSArray *strArray = [object componentsSeparatedByString:@" "];
        NSMutableArray *separatedStrings = [NSMutableArray arrayWithCapacity:[strArray count]];
        [separatedStrings addObjectsFromArray:strArray];
        //NSMutableArray *separatedStrings = (NSString*)[object componentsSeparatedByString:@" "];
        NSString *filename;
        if ([[separatedStrings objectAtIndex:0]  isEqual: @"deb"]) {
            if (![[separatedStrings objectAtIndex:1] isEqual:@"[trusted=yes]"]) {
                NSString *filenameA = [[[separatedStrings objectAtIndex:1] stringByReplacingOccurrencesOfString:@"/" withString:@"_"] stringByReplacingOccurrencesOfString:@"https:__" withString:@""];
                NSString *filenameB = [[separatedStrings objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
                filename = [NSString stringWithFormat:@"%@_dists_%@_Release", filenameA, filenameB];
                [repositories addObject:(NSString*)[separatedStrings objectAtIndex:1]];
            } else {
                NSString *filenameA = [[[separatedStrings objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/" withString:@"_"] stringByReplacingOccurrencesOfString:@"https:__" withString:@""];
                NSString *filenameB = [[separatedStrings objectAtIndex:3] stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
                filename = [NSString stringWithFormat:@"%@_dists_%@_Release", filenameA, filenameB];
                [repositories addObject:(NSString*)[separatedStrings objectAtIndex:2]];
            }
            [repositoriesFilenames addObject:[NSString stringWithFormat:@"/usr/local/var/lib/apt/lists/%@", filename]];
        }
    }
    
    [repositoriesFilenames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *content = [NSString stringWithContentsOfFile:obj encoding:NSUTF8StringEncoding error:nil];
        NSMutableArray *contentLines = [NSMutableArray arrayWithArray:[content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
        NVSRepo *repo = [[NVSRepo alloc] init];
        [contentLines enumerateObjectsUsingBlock:^(id obj, NSUInteger idxer, BOOL *stop) {
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
        NSString *packagesPath = [[repositoriesFilenames objectAtIndex:idx] stringByReplacingOccurrencesOfString:@"_Release" withString:@""];
        repo.packages = [self packagesFromPath:[[NSString stringWithFormat:@"%@_%@_binary-%@_Packages", packagesPath, repo.components, repo.architectures] cStringUsingEncoding:NSASCIIStringEncoding]];
        [self.addedRepositories insertObject:repo atIndex:idx];
    }];
    
    NSLog(@"Got %lu Repos", repositoriesFilenames.count);
    return self;
}

@end
