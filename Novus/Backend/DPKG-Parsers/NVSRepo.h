//
//  NVSRepo.h
//  Novus
//
//  Created by EvenDev on 02/07/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVSRepo : NSObject

@property (nonatomic, retain) NSString *origin;
@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSString *suite;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *codename;
@property (nonatomic, retain) NSString *architectures;
@property (nonatomic, retain) NSString *components;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSMutableArray *packages;
@property (nonatomic, retain) NSDate *lastUpdated;

@property (nonatomic, retain) NSString *releaseURL;
@property (nonatomic, retain) NSString *packagesURL;
@property (nonatomic, retain) NSString *releasePath;
@property (nonatomic, retain) NSString *packagesPath;
@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, retain) NSImage *image;
@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *repoURL;

@end
