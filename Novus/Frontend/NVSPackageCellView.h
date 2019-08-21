//
//  NVSPackageCellView.h
//  Novus
//
//  Created by EvenDev on 21/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVSPackageCellView : NSTableCellView

@property (strong) IBOutlet NSTextField *maintainerField;
@property (strong) IBOutlet NSTextField *descField;

@end

NS_ASSUME_NONNULL_END
