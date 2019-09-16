//
//  NVSDepictionViewController.h
//  Novus
//
//  Created by EvenDev on 12/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../Backend/DPKG-Parsers/NVSPackage.h"
#import "../Backend/DPKG-Parsers/NVSRepo.h"
#import "../Backend/Database/NVSPackageManager.h"
#import "../Backend/Utilities/debug.h"
#import "../ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSDepictionViewController : NSViewController

@property (nonatomic, retain) NVSPackage *package;
@property (strong) IBOutlet NSScrollView *scrollView;
@property (strong) IBOutlet NSBox *box;
@property (strong) IBOutlet NSBox *getButton;
@property (strong) IBOutlet NSTextField *getButtonTitle;

// Top Depiction
@property (strong) IBOutlet NSTextField *packageName;
@property (strong) IBOutlet NSTextField *packageMaintainer;
@property (strong) IBOutlet NSTextField *packageRepo;
@property (strong) IBOutlet NSImageView *packageIcon;
@property (strong) IBOutlet NSTextField *packageReviewScore;
@property (strong) IBOutlet NSTextField *packageReviewCount;

// Screenshots
@property (strong) IBOutlet NSScrollView *previewScrollview;

// Description
@property (strong) IBOutlet NSTextField *packageDescription;

// Latest Update
@property (strong) IBOutlet NSView *latestUpdateView;
@property (strong) IBOutlet NSTextField *latestUpdateDescription;
@property (strong) IBOutlet NSTextField *latestUpdateInformation;

// Ratings & Reviews
@property (strong) IBOutlet NSView *ratingsView;
@property (strong) IBOutlet NSTextField *ratingScore;

@property (strong) IBOutlet NSBox *firstReview;
@property (strong) IBOutlet NSTextField *firstReviewTitle;
@property (strong) IBOutlet NSImageView *firstReviewStars;
@property (strong) IBOutlet NSTextField *firstReviewContent;
@property (strong) IBOutlet NSTextField *firstReviewDate;
@property (strong) IBOutlet NSTextField *firstReviewUser;

@property (strong) IBOutlet NSBox *secondReview;
@property (strong) IBOutlet NSTextField *secondReviewTitle;
@property (strong) IBOutlet NSImageView *secondReviewStars;
@property (strong) IBOutlet NSTextField *secondReviewContent;
@property (strong) IBOutlet NSTextField *secondReviewDate;
@property (strong) IBOutlet NSTextField *secondReviewUser;

// Information
@property (strong) IBOutlet NSView *informationView;
@property (strong) IBOutlet NSTextField *informationMaintainer;
@property (strong) IBOutlet NSTextField *informationVersion;
@property (strong) IBOutlet NSTextField *informationRepository;
@property (strong) IBOutlet NSTextField *informationSize;
@property (strong) IBOutlet NSTextField *informationCategory;
@property (strong) IBOutlet NSTextField *informationIdentifier;

// Buttons
@property (strong) IBOutlet NSButtonCell *developerSiteButton;


@end

NS_ASSUME_NONNULL_END
