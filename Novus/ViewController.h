//
//  ViewController.h
//  Novus
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LMDPKGParser.h"
#import "NVSPackage.h"

@interface NVSPackageCellView : NSTableCellView
@property (strong) IBOutlet NSTextField *maintainerField;
@property (strong) IBOutlet NSTextField *descField;

@end

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTabView *tabView;
@property (nonatomic,retain) LMDPKGParser *parser;

//
//   TODAY PAGE
//

@property (strong) IBOutlet NSTextField *todayDateLabel;
@property (strong) IBOutlet NSBox *todayNovusCard;
@property (strong) IBOutlet NSBox *firstEditorCard;
@property (strong) IBOutlet NSBox *secondEditorCard;

//
//   PACKAGES PAGE
//

@property (strong) IBOutlet NSTextField *packagesDatelabel;
@property (strong) IBOutlet NSTableView *packagesTableView;

//
//   SIDEBAR
//

// Store Section
@property (strong) IBOutlet NSImageView *storeImage;
@property (strong) IBOutlet NSTextField *storeLabel;
@property (strong) IBOutlet NSTextField *todayLabel;
@property (strong) IBOutlet NSTextField *newsLabel;
@property (strong) IBOutlet NSTextField *updatesLabel;

// Categories Section
@property (strong) IBOutlet NSImageView *categoryImage;
@property (strong) IBOutlet NSTextField *categoryLabel;
@property (strong) IBOutlet NSTextField *appLabel;
@property (strong) IBOutlet NSTextField *tweakLabel;
@property (strong) IBOutlet NSTextField *themesLabel;

// Manage Section
@property (strong) IBOutlet NSImageView *ManageImage;
@property (strong) IBOutlet NSTextField *manageLabel;
@property (strong) IBOutlet NSTextField *repoLabel;
@property (strong) IBOutlet NSTextField *packageLabel;

@end

