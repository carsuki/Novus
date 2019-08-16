//
//  BrowseRepoController.h
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVSRepo.h"
#import "NVSPackage.h"
#import "ViewRepoPackageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BrowseRepoController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTableView *tableView;
@property (nonatomic, retain) NVSRepo *repo;
@property (strong) IBOutlet NSTextField *titleField;

@end

NS_ASSUME_NONNULL_END
