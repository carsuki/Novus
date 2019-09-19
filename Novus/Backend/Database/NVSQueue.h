//
//  NVSQueue.h
//  Novus
//
//  Created by EvenDev on 18/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Objects/NVSQueueAction.h"
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVSQueue : NSObject

@property (nonatomic, strong) NSMutableArray *actions;

+(id)sharedInstance;
-(id)init;
-(NSMutableArray*)queueActions;
-(void)clear;
-(void)addQueueAction:(NVSQueueAction *)action;

@end

NS_ASSUME_NONNULL_END
