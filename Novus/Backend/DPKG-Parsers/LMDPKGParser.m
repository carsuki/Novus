//
//  LMDPKGParser.m
//  Lime
//
//  Created by ArtikusHG on 4/30/19.
//  Copyright © 2019 Daniel. All rights reserved.
//
//  Special thanks to the Lime team for providing the DPKG parser files, Lime team is complety credited and their Twitter can be found here: https://twitter.com/limeinstaller.

//  Lime is a package manager for Jailbroken iOS devices.


#import "LMDPKGParser.h"
#import "NVSPackage.h"

@implementation LMDPKGParser

- (instancetype)init {
    self = [super init];
    self.installedPackages = [[NSMutableArray alloc] init];
    
    NSLog(@"init parser");
    
    NSMutableArray *packages = [[NSMutableArray alloc] init];
    FILE *file = fopen("/usr/local/var/lib/dpkg/status", "r");
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
            if(self.installedPackages.count < packages.count) {
                NSInteger index = [packages indexOfObject:lastObject];
            
                NVSPackage *package = [NVSPackage new];
                package.identifier = [packages objectAtIndex:index];
                package.desc = lastDesc;
                package.maintainer = lastMaintainer;
                package.section = lastSection;
                package.installedSize = lastSize;
                package.version = lastVersion;
                package.section = lastSection;
                
                [self.installedPackages insertObject:package atIndex:index];
                
                lastDesc = @"";
                lastMaintainer = @"";
                lastVersion = @"";
                lastSize = @"";
                lastSection = @"";
            }
        }
    }
    fclose(file);
    NSLog(@"Got %lu Packages", self.installedPackages.count);
    return self;
}

@end
