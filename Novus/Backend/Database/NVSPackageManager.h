//
//  NVSPackageManager.h
//  Novus
//
//  Created by EvenDev on 04/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../DPKG-Parsers/LMPackageParser.h"
#import "../DPKG-Parsers/NVSPackage.h"
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVSPackageManager : NSObject

@property (nonatomic, retain) NSMutableDictionary *packagesDict;
@property (nonatomic, retain) NSMutableArray *packagesArray;
@property (nonatomic, retain) NSMutableDictionary *installedPackagesDict;
@property (nonatomic, retain) NSMutableArray *installedPackagesArray;
@property (nonatomic, retain) NSMutableArray *sourcesInList;
@property (nonatomic, retain) NSMutableArray *sources;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;

+(id)sharedInstance;
-(id)init;
-(void)getInstalledPackages;

@end

NS_ASSUME_NONNULL_END
