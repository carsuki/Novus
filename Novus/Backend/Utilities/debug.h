//
//  debug.h
//  Novus
//
//  Created by Ultra on 7/31/19.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef debug_h
#define debug_h

#ifndef DEBUG
#define DEBUG 1
#endif

#if (DEBUG == 1)
#define DEBUGLOG(str, ...) do { \
NSLog(@str, ##__VA_ARGS__); \
} while(0)
#else
#define DEBUGLOG(str, ...)
#endif

#endif /* debug_h */
