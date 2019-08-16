//
//  InstalledPackagesController.h
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMPackageParser.h"
#import "NVSPackage.h"
#import "ViewInstalledPackageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InstalledPackagesController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTableView *tableView;
@property (nonatomic, retain) LMPackageParser *parser;

@end

NS_ASSUME_NONNULL_END
