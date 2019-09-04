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

NS_ASSUME_NONNULL_BEGIN

@interface NVSPackageManager : NSObject

@property (nonatomic, retain) NSMutableDictionary *packagesDict;
@property (nonatomic, retain) NSMutableArray *packagesArray;

+(id)sharedInstance;

@end

NS_ASSUME_NONNULL_END
