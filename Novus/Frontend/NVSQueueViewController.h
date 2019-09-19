//
//  NVSQueueViewController.h
//  Novus
//
//  Created by EvenDev on 18/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../Backend/Objects/NVSQueueAction.h"
#import "../Backend/Database/NVSQueue.h"
#import "NVSQueueCellView.h"
#import "NVSLogViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSQueueViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSButton *button;
@property (strong) IBOutlet NSTextField *buttonLabel;

@end

NS_ASSUME_NONNULL_END
