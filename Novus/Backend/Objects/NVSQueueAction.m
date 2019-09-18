//
//  NVSQueueAction.m
//  Novus
//
//  Created by EvenDev on 18/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSQueueAction.h"

@implementation NVSQueueAction

-(instancetype)initWithPackage:(NVSPackage*)package action:(NSInteger)action {
    self = [super init];
    if (self) {
        self.package = package;
        self.action = action;
    }
    return self;
}

@end
