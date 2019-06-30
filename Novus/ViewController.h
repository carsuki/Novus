//
//  ViewController.h
//  Novus
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (strong) IBOutlet NSTabView *tabView;

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

