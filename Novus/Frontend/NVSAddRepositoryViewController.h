//
//  NVSAddRepositoryViewController.h
//  Novus
//
//  Created by EvenDev on 27/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVSAddRepositoryViewController : NSViewController
@property (strong) IBOutlet NSBox *cancelButtonBox;
@property (strong) IBOutlet NSBox *saveButtonBox;
@property (strong) IBOutlet NSTextField *titleField;
@property (strong) IBOutlet NSTextField *secondTitleField;
@property (strong) IBOutlet NSTextField *textview;

@end

NS_ASSUME_NONNULL_END
