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
        LMPackageParser *parser = [[LMPackageParser alloc] initWithFilePath:@"/usr/local/var/lib/dpkg/status"];
        instance.packagesArray = [NSMutableArray new];
        instance.packagesDict = [NSMutableDictionary new];
        [parser.packages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NVSPackage *pkg = obj;
            [instance.packagesArray addObject:pkg];
            [instance.packagesDict setObject:pkg forKey:pkg.identifier];
        }];
    });
    
    return instance;
}

@end
