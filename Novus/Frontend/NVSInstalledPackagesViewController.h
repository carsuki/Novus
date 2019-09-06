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
#import "../Backend/Database/NVSPackageManager.h"
#import "../Backend/DPKG-Parsers/NVSRepo.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSInstalledPackagesViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTextField *dateLabel;
@property (strong) IBOutlet NSTableView *tableView;

@end

NS_ASSUME_NONNULL_END
