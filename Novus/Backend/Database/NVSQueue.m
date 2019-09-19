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
        self.actions = [NSMutableArray new];
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
    __block NSUInteger found = 1;
    NSLog(@"%ld", (long)found);
    [self.actions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSQueueAction *owoAction = obj;
        if (action.package.identifier == owoAction.package.identifier) {
            found = 0;
        }
        }];
    NSLog(@"%ld", (long)found);
    if (found > 0) {
        [self.actions addObject:action];
        if (action.action == 0) {
            NSLog(@"%@ shall be installed!", action.package.identifier);
        } else if (action.action == 1) {
            NSLog(@"Added %@ to the queue of destruction", action.package.identifier);
        }
    } else {
        NSLog(@"%@ is trying to clone itself.", action.package.identifier);
    }
}

@end
