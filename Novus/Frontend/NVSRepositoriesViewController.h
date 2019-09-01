//
//  NVSRepositoriesViewController.h
//  Novus
//
//  Created by EvenDev on 26/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../Backend/DPKG-Parsers/NVSRepo.h"
#import "NVSRepoCellView.h"
#import "../Backend/DPKG-Parsers/LMPackageParser.h"
#import "../Backend/Utilities/NVSCommandWrapper.h"
#import "../ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSRepositoriesViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTextField *titleField;
@property (strong) IBOutlet NSTableView *tableView;
@property (nonatomic, retain) NSMutableArray *sourcesInList;
@property (nonatomic, retain) NSMutableArray *sources;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSDateFormatter *lastDateFormatter;

@end

NS_ASSUME_NONNULL_END
