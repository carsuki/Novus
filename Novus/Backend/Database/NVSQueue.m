//
//  NVSQueue.m
//  Novus
//
//  Created by EvenDev on 18/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSQueue.h"

@implementation NVSQueue

+ (id)sharedInstance {
    static NVSQueue *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

-(id)init {
    self = [super init];
    if (self) {
        NVSQueueAction *a1 = [NVSQueueAction new];
        NVSPackage *package1 = [NVSPackage new];
        package1.identifier = @"cartool";
        package1.section = @"Utilities";
        package1.icon = [NSImage imageNamed:package1.section];
        a1.action = 1;
        a1.package = package1;
        NVSQueueAction *a2 = [NVSQueueAction new];
        NVSPackage *package2 = [NVSPackage new];
        package2.identifier = @"ant";
        package2.section = @"Tweaks";
        package2.icon = [NSImage imageNamed:package2.section];
        a2.action = 1;
        a2.package = package2;
        NVSQueueAction *a3 = [NVSQueueAction new];
        NVSPackage *package3 = [NVSPackage new];
        package3.identifier = @"lolcat";
        package3.section = @"Toys";
        package3.icon = [NSImage imageNamed:package3.section];
        a3.action = 0;
        a3.package = package3;
        self.actions = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:a1, a2, a3, nil]];
    }
    return self;
}

-(void)clear {
    self.actions = [NSMutableArray new];
}

-(NSMutableArray*)queueActions {
    return self.actions;
}

-(void)addQueueAction:(NVSQueueAction *)action {
    __block BOOL found;
    [self.actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSQueueAction *existingAction = obj;
        if ([existingAction.package.identifier isEqualToString:action.package.identifier]) {
            found = YES;
        }
    }];
    if (!found) {
        [self.actions addObject:action];
    } else {
        NSLog(@"%@ is already added to the queue", action.package.identifier);
    }
}

@end
