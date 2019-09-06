//
//  NVSSearchViewController.h
//  Novus
//
//  Created by EvenDev on 06/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../Backend/Database/NVSPackageManager.h"
#import "NVSPackageCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSSearchViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, retain) NSString *searchQuery;
@property (strong) IBOutlet NSTextField *titleField;
@property (nonatomic, retain) NSMutableArray *results;
@property (strong) IBOutlet NSTableView *tableView;

@end

NS_ASSUME_NONNULL_END
