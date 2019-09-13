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
    NSLog(@"Trying to remove %@", self.identifier);
    NVSCommandWrapper *cmdWrapper = [NVSCommandWrapper sharedInstance];
    NSArray *output = [cmdWrapper runAsRoot:[NSString stringWithFormat:@"/usr/local/bin/dpkg -r %@", [self identifier]]];
    
    if(output == NULL) {
        NSLog(@"Error getting root while removing package: %@", [self identifier]);
        return -1;
    }
    
    NSString *stdout = [output objectAtIndex:0];
    NSString *stderr = [output objectAtIndex:1];
    
    if(![stderr isEqualToString:@""]) {
        NSLog(@"APT error while removing package %@\nstderr:%@", [self identifier], stdout);
        return -2;
    }
    
    NSLog(@"Successfully removed package %@", [self identifier]);
    NSLog(stdout);
    return 0;
}

- (int)install {
    NSLog(@"Trying to install %@", self.identifier);
    NVSCommandWrapper *cmdWrapper = [NVSCommandWrapper sharedInstance];
    NSData *deb = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.debURL]];
    if (deb) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/Novus/debs/%@", documentsDirectory, [NSString stringWithFormat:@"%@-%@.deb", self.identifier, self.version]];
        BOOL isDir;
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Novus/debs/", documentsDirectory] isDirectory:&isDir]) {
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/Novus/debs/", documentsDirectory] withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"%@", error);
            }
        }
        [deb writeToFile:filePath atomically:YES];
        NSLog(@"Successfully downloaded deb to %@", filePath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSArray *output = [cmdWrapper runAsRoot:[NSString stringWithFormat:@"/usr/local/bin/dpkg -i %@", filePath]];
            
            if(output == NULL) {
                NSLog(@"Error getting root while installing package: %@", [self identifier]);
                return -1;
            }
            
            NSString *stdout = [output objectAtIndex:0];
            
            NSLog(@"Successfully installed package %@", [self identifier]);
            return 0;
        }
    } else {
        NSLog(@"Failed to install %@, couldn't download file: %@", self.identifier, self.debURL);
        return -3;
    }
    return -4;
}

@end
