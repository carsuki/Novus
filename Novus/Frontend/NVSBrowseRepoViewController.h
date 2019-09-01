//
//  NVSBrowseRepoViewController.h
//  Novus
//
//  Created by EvenDev on 01/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../Backend/DPKG-Parsers/NVSRepo.h"
#import "../Backend/DPKG-Parsers/NVSPackage.h"
#import "NVSPackageCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSBrowseRepoViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, retain) NVSRepo *repo;
@property (strong) IBOutlet NSTextField *dateLabel;
@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSTextField *titleField;

@end

NS_ASSUME_NONNULL_END
