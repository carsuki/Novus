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

- (int)remove {
    NVSCommandWrapper *cmdWrapper = [NVSCommandWrapper sharedInstance];
    NSArray *output = [cmdWrapper runAsRoot:[NSString stringWithFormat:@"unbuffer apt-get -yqf -oquiet::NoStatistic=true -oquiet::NoUpdate=true -oquiet::NoProgress=true -oApt::Get::HideAutoRemove=true --allow-remove-essential --allow-downgrades --reinstall install %@-", [self identifier]]];
    
    if(output == NULL) {
        NSLog(@"Error getting root while removing package: %@", [self identifier]);
        return -1;
    }
    
    NSString *stdout = [[NSString alloc] initWithData:[output objectAtIndex:0] encoding:NSUTF8StringEncoding];
    NSString *stderr = [[NSString alloc] initWithData:[output objectAtIndex:1] encoding:NSUTF8StringEncoding];
    
    /*
    if(![stderr isEqualToString:@""]) {
        NSLog(@"APT error while removing package %@\nstderr:%@", [self identifier], stdout);
        return -2;
    }
     */
    
    NSLog(@"Removing package %@...", [self identifier]);
    NSLog(stdout);
    self.installed = NO;
    //NSLog(@"%@ is installed: %b", self.identifier, self.installed);
    return 0;
}

- (int)install {
    NVSCommandWrapper *cmdWrapper = [NVSCommandWrapper sharedInstance];
    NSArray *output = [cmdWrapper runAsRoot:[NSString stringWithFormat:@"unbuffer apt-get -yqf -oquiet::NoStatistic=true -oquiet::NoUpdate=true -oquiet::NoProgress=true -oApt::Get::HideAutoRemove=true --allow-remove-essential --allow-downgrades --reinstall install %@", [self identifier]]];
    
    if(output == NULL) {
        NSLog(@"Error getting root while installing package: %@", [self identifier]);
        return -1;
    }
    
    NSString *stdout = [[NSString alloc] initWithData:[output objectAtIndex:0] encoding:NSUTF8StringEncoding];
    NSString *stderr = [[NSString alloc] initWithData:[output objectAtIndex:1] encoding:NSUTF8StringEncoding];
    
    /*
    if(![stderr isEqualToString:@""]) {
        NSLog(@"APT error while installing package %@\nstderr:%@", [self identifier], stdout);
        return -2;
    }
     */
    
    NSLog(@"Installing package %@...", [self identifier]);
    NSLog(stdout);
    self.installed = YES;
    //NSLog(@"%@ is installed: %b", self.identifier, self.installed);
    return 0;
}

@end
