//
//  NVSLogViewController.h
//  Novus
//
//  Created by EvenDev on 15/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVSLogViewController : NSViewController

@property (nonatomic, retain) NSString *command;
@property (strong) IBOutlet NSTextView *logView;

@end

NS_ASSUME_NONNULL_END
