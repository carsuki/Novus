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
@synthesize size;


- (id)initWithIdentifier:(NSString *)identifier {
    
    self = [super init];
    
    if(self) {
        [self setIdentifier:identifier];
    }
    
    return self;
    
}

- (int)install {
    NVSCommandWrapper *cmdWrapper = [NVSCommandWrapper sharedInstance];
    NSArray *output = [cmdWrapper runAsRoot:[NSString stringWithFormat:@"apt install %@", [self identifier]]];
    
    if(output == NULL) {
        NSLog([NSString stringWithFormat:@"Error getting root while installing package: %@", [self identifier]]);
        return -1;
    }
    
    NSString *stdout = [output objectAtIndex:0];
    NSString *stderr = [output objectAtIndex:1];
    
    if(![stderr isEqualToString:@""]) {
        NSLog([NSString stringWithFormat:@"APT error while installing package %@\nstderr:%@", [self identifier], stdout]);
        return -2;
    }
    
    NSLog([NSString stringWithFormat:@"Installing package %@...", [self identifier]]);
    NSLog(stdout);
    return 0;
}

@end
