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

@end
