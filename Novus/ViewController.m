//
//  ViewController.m
//  Novus
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "ViewController.h"
#import "Backend/Database/NVSDatabaseManager.h"

@interface ViewController()

@property (nonatomic, strong) NVSDatabaseManager *dbManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NVSCommandWrapper sharedInstance] runAsUser:@"whoami"];
    [[NVSCommandWrapper sharedInstance] runAsRoot:@"whoami"];
}

-(void)viewWillAppear {
    [super viewWillAppear];
    
    [NVSPackageManager sharedInstance];
}

-(IBAction)search:(id)sender {
    if (self.searchField.stringValue.length > 0) {
        NVSSearchViewController *controller = [self.storyboard instantiateControllerWithIdentifier:@"search"];
        controller.searchQuery = self.searchField.stringValue;
        [self addChildViewController:controller];
        [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        controller.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.containerView addSubview:controller.view];
        [NSLayoutConstraint activateConstraints:@[[controller.view.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor], [controller.view.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor], [controller.view.topAnchor constraintEqualToAnchor:self.containerView.topAnchor], [controller.view.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor]]];
    }
}

-(void)browseRepo:(NVSRepo *)repo {
    NVSBrowseRepoViewController *controller = [self.storyboard instantiateControllerWithIdentifier:@"viewRepo"];
    controller.repo = repo;
    [self addChildViewController:controller];
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:controller.view];
    [NSLayoutConstraint activateConstraints:@[[controller.view.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor], [controller.view.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor], [controller.view.topAnchor constraintEqualToAnchor:self.containerView.topAnchor], [controller.view.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor]]];
}

-(void)openTab:(NSInteger)index {
    NSLog(@"Open view%ld", (long)index);
    NSViewController *controller = [self.storyboard instantiateControllerWithIdentifier:[NSString stringWithFormat:@"view%ld", (long)index]];
    [self addChildViewController:controller];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:controller.view];
    [NSLayoutConstraint activateConstraints:@[[controller.view.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor], [controller.view.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor], [controller.view.topAnchor constraintEqualToAnchor:self.containerView.topAnchor], [controller.view.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor]]];
    
    NSColor *gray = [NSColor colorWithWhite:0.443137254901961 alpha:1];
    NSColor *grayer = [NSColor colorWithRed:0.552941176470588 green:0.588235294117647 blue:0.623529411764706 alpha:1];
    NSColor *purple = [NSColor colorWithRed:0.505882352941176 green:0.4 blue:0.776470588235294 alpha:1];
    
    // messy color changing ugh
    if (index == 0) {
        _storeLabel.textColor = purple;
        _storeImage.image = [NSImage imageNamed:@"StoreSelected"];
        _todayLabel.textColor = purple;
        _newsLabel.textColor = gray;
        _updatesLabel.textColor = gray;
        _categoryLabel.textColor = grayer;
        _categoryImage.image = [NSImage imageNamed:@"Categories"];
        _appLabel.textColor = gray;
        _tweakLabel.textColor = gray;
        _themesLabel.textColor = gray;
        _manageLabel.textColor = grayer;
        _ManageImage.image = [NSImage imageNamed:@"Manage"];
        _repoLabel.textColor = gray;
        _packageLabel.textColor = gray;
    }
    if (index == 1) {
        _storeLabel.textColor = purple;
        _storeImage.image = [NSImage imageNamed:@"StoreSelected"];
        _todayLabel.textColor = gray;
        _newsLabel.textColor = purple;
        _updatesLabel.textColor = gray;
        _categoryLabel.textColor = grayer;
        _categoryImage.image = [NSImage imageNamed:@"Categories"];
        _appLabel.textColor = gray;
        _tweakLabel.textColor = gray;
        _themesLabel.textColor = gray;
        _manageLabel.textColor = grayer;
        _ManageImage.image = [NSImage imageNamed:@"Manage"];
        _repoLabel.textColor = gray;
        _packageLabel.textColor = gray;
    }
    if (index == 2) {
        _storeLabel.textColor = purple;
        _storeImage.image = [NSImage imageNamed:@"StoreSelected"];
        _todayLabel.textColor = gray;
        _newsLabel.textColor = gray;
        _updatesLabel.textColor = purple;
        _categoryLabel.textColor = grayer;
        _categoryImage.image = [NSImage imageNamed:@"Categories"];
        _appLabel.textColor = gray;
        _tweakLabel.textColor = gray;
        _themesLabel.textColor = gray;
        _manageLabel.textColor = grayer;
        _ManageImage.image = [NSImage imageNamed:@"Manage"];
        _repoLabel.textColor = gray;
        _packageLabel.textColor = gray;
    }
    if (index == 3) {
        _storeLabel.textColor = grayer;
        _storeImage.image = [NSImage imageNamed:@"Store"];
        _todayLabel.textColor = gray;
        _newsLabel.textColor = gray;
        _updatesLabel.textColor = gray;
        _categoryLabel.textColor = purple;
        _categoryImage.image = [NSImage imageNamed:@"CategoriesSelected"];
        _appLabel.textColor = purple;
        _tweakLabel.textColor = gray;
        _themesLabel.textColor = gray;
        _manageLabel.textColor = grayer;
        _ManageImage.image = [NSImage imageNamed:@"Manage"];
        _repoLabel.textColor = gray;
        _packageLabel.textColor = gray;
    }
    if (index == 4) {
        _storeLabel.textColor = grayer;
        _storeImage.image = [NSImage imageNamed:@"Store"];
        _todayLabel.textColor = gray;
        _newsLabel.textColor = gray;
        _updatesLabel.textColor = gray;
        _categoryLabel.textColor = purple;
        _categoryImage.image = [NSImage imageNamed:@"CategoriesSelected"];
        _appLabel.textColor = gray;
        _tweakLabel.textColor = purple;
        _themesLabel.textColor = gray;
        _manageLabel.textColor = grayer;
        _ManageImage.image = [NSImage imageNamed:@"Manage"];
        _repoLabel.textColor = gray;
        _packageLabel.textColor = gray;
    }
    if (index == 5) {
        _storeLabel.textColor = grayer;
        _storeImage.image = [NSImage imageNamed:@"Store"];
        _todayLabel.textColor = gray;
        _newsLabel.textColor = gray;
        _updatesLabel.textColor = gray;
        _categoryLabel.textColor = purple;
        _categoryImage.image = [NSImage imageNamed:@"CategoriesSelected"];
        _appLabel.textColor = gray;
        _tweakLabel.textColor = gray;
        _themesLabel.textColor = purple;
        _manageLabel.textColor = grayer;
        _ManageImage.image = [NSImage imageNamed:@"Manage"];
        _repoLabel.textColor = gray;
        _packageLabel.textColor = gray;
    }
    if (index == 6) {
        _storeLabel.textColor = grayer;
        _storeImage.image = [NSImage imageNamed:@"Store"];
        _todayLabel.textColor = gray;
        _newsLabel.textColor = gray;
        _updatesLabel.textColor = gray;
        _categoryLabel.textColor = grayer;
        _categoryImage.image = [NSImage imageNamed:@"Categories"];
        _appLabel.textColor = gray;
        _tweakLabel.textColor = gray;
        _themesLabel.textColor = gray;
        _manageLabel.textColor = purple;
        _ManageImage.image = [NSImage imageNamed:@"ManageSelected"];
        _repoLabel.textColor = purple;
        _packageLabel.textColor = gray;
    }
    if (index == 7) {
        _storeLabel.textColor = grayer;
        _storeImage.image = [NSImage imageNamed:@"Store"];
        _todayLabel.textColor = gray;
        _newsLabel.textColor = gray;
        _updatesLabel.textColor = gray;
        _categoryLabel.textColor = grayer;
        _categoryImage.image = [NSImage imageNamed:@"Categories"];
        _appLabel.textColor = gray;
        _tweakLabel.textColor = gray;
        _themesLabel.textColor = gray;
        _manageLabel.textColor = purple;
        _ManageImage.image = [NSImage imageNamed:@"ManageSelected"];
        _repoLabel.textColor = gray;
        _packageLabel.textColor = purple;
    }
}

- (IBAction)goStore:(id)sender {[self openTab:0];}
- (IBAction)goToday:(id)sender {[self openTab:0];}
- (IBAction)goNews:(id)sender {[self openTab:1];}
- (IBAction)goUpdates:(id)sender {[self openTab:2];}
- (IBAction)goCategories:(id)sender {[self openTab:3];}
- (IBAction)goApps:(id)sender {[self openTab:3];}
- (IBAction)goTweaks:(id)sender {[self openTab:4];}
- (IBAction)goThemes:(id)sender {[self openTab:5];}
- (IBAction)goManage:(id)sender {[self openTab:6];}
- (IBAction)goRepo:(id)sender {[self openTab:6];}
- (IBAction)goPackage:(id)sender {[self openTab:7];}

@end
