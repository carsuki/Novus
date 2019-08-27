//
//  NVSCommandWrapper.h
//  Novus
//
//  Created by Ultra on 7/30/19.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#ifndef NVSCommandWrapper_h
#define NVSCommandWrapper_h

@interface NVSCommandWrapper : NSObject

+(id)sharedInstance;
-(NSArray *)runAsUser:(NSString *)commandWithArguments;
-(NSArray *)runAsRoot:(NSString *)commandWithArgs;

@end

#endif /* NVSCommandWrapper_h */
