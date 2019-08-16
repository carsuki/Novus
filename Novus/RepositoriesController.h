//
//  RepositoriesController.h
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVSRepo.h"
#import "LMPackageParser.h"
#import "NVSPackage.h"
#import "BrowseRepoController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepositoriesController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTableView *tableView;
@property (nonatomic, retain) NSMutableArray *sourcesInList;
@property (nonatomic, retain) NSMutableArray *sources;

@end

NS_ASSUME_NONNULL_END
