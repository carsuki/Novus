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

- (instancetype)init {
    self = [super init];
    self.addedRepositories = [[NSMutableArray alloc] init];
    self.tempRepo = [[NSMutableArray alloc] init];
    
    NSLog(@"init repo parser");
    
    NSMutableArray *repositories = [[NSMutableArray alloc] init];
    NSMutableArray *repositoriesFilenames = [[NSMutableArray alloc] init];
    
    NSMutableArray *contentsOfListDir = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/usr/local/var/lib/apt/lists" error:nil] mutableCopy];
    NSString *novusList = [NSString stringWithContentsOfFile:@"/usr/local/etc/apt/sources.list.d/novus.list" encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *novusListLines = [NSMutableArray arrayWithArray:[novusList componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    for(id string in novusListLines) {
        if([string isEqualToString:@""]) {
            [novusListLines removeObject:string];
        }
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
        [self.addedRepositories insertObject:repo atIndex:idx];
    }];
    
    NSLog(@"Got %lu Repos", repositoriesFilenames.count);
    return self;
}

@end
