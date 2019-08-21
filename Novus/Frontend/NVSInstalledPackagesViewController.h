//
//  NVSInstalledPackagesViewController.h
//  Novus
//
//  Created by EvenDev on 21/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../Backend/DPKG-Parsers/NVSPackage.h"
#import "../Backend/DPKG-Parsers/LMPackageParser.h"
#import "NVSPackageCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSInstalledPackagesViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTextField *dateLabel;
@property (strong) IBOutlet NSTableView *tableView;
@property (nonatomic, retain) LMPackageParser *parser;

@end

NS_ASSUME_NONNULL_END
