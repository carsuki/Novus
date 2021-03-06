//
//  ViewController.h
//  Novus
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Backend/DPKG-Parsers/NVSRepo.h"
#import "NVSPackage.h"
#import "Backend/Utilities/NVSCommandWrapper.h"
#import "Frontend/NVSRepositoriesViewController.h"
#import "Frontend/NVSBrowseRepoViewController.h"
#import "Backend/Database/NVSPackageManager.h"
#import "Frontend/NVSSearchViewController.h"
#import "Frontend/NVSDepictionViewController.h"
#import "Frontend/NVSLogViewController.h"
#import "Backend/Database/NVSQueue.h"

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NVSCommandWrapper *cmdWrapper;
@property (nonatomic, strong) NSString *tempCommand;
@property (strong) IBOutlet NSView *containerView;

//
//  SIDEBAR
//

@property (strong) IBOutlet NSSearchField *searchField;

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

-(void)openTab:(NSInteger)index;
-(void)browseRepo:(NVSRepo *)repo;
-(void)viewPackage:(NVSPackage *)pkg;
-(void)openLogViewAndRunCommand:(NSString *)command;
-(IBAction)search:(id)sender;

@end
