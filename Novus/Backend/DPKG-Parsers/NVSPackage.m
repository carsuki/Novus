//
//  NVSPackage.m
//  AppStoreUI
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSPackage.h"

@implementation NVSPackage

@synthesize identifier;
@synthesize name;
@synthesize version;
@synthesize desc;
@synthesize section;
@synthesize architecture;
@synthesize author;
@synthesize maintainer;
@synthesize installedSize;
@synthesize repoUrl;


- (id)initWithIdentifier:(NSString *)identifier name:(NSString *)name version:(NSString *)version description:(NSString *)desc section:(NSString *)section architecture:(NSString *)arch author:(NSString *)author maintainer:(NSString *)maintainer installedSize:(NSString *)size repoUrl:(NSString *)repoUrl {
    
    self = [super init];
    
    if(self) {
        [self setIdentifier:identifier];
        [self setName:name];
        [self setVersion:version];
        [self setDesc:desc];
        [self setSection:section];
        [self setArchitecture:arch];
        [self setAuthor:author];
        [self setMaintainer:maintainer];
        [self setInstalledSize:size];
        [self setRepoUrl:repoUrl];
    }
    
    return self;
    
}

- (void)install {
    NVSCommandWrapper *cmdWrapper = [NVSCommandWrapper sharedInstance];
    NSArray *output = [cmdWrapper runAsRoot:[NSString stringWithFormat:@"apt install %@", [self identifier]]];
}

@end
