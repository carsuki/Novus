//
//  NVSQueueAction.h
//  Novus
//
//  Created by EvenDev on 18/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../DPKG-Parsers/NVSPackage.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSQueueAction : NSObject

@property (nonatomic) NSInteger action;
@property (nonatomic, retain) NVSPackage *package;

-(instancetype)initWithPackage:(NVSPackage*)package action:(NSInteger)action;

@end

NS_ASSUME_NONNULL_END
