//
//  ViewController.m
//  Novus
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "ViewController.h"

@implementation NVSPackageCellView

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parser = [[LMDPKGParser alloc] init];
    
    // packages view
    self.packagesTableView.delegate = self;
    self.packagesTableView.dataSource = self;

    // dates
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE d MMMM"];
    self.todayDateLabel.stringValue = [[formatter stringFromDate:[NSDate date]] uppercaseString];
    self.packagesDatelabel.stringValue = [[formatter stringFromDate:[NSDate date]] uppercaseString];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.parser.installedPackages.count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSPackageCellView *view = [tableView makeViewWithIdentifier:@"PackageCell" owner:self];
    NVSPackage *pkg = [self.parser.installedPackages objectAtIndex:row];
    view.textField.stringValue = pkg.identifier;
    NSArray *maintainer = [pkg.maintainer componentsSeparatedByString:@"<"];
    view.maintainerField.stringValue = [maintainer objectAtIndex:0];
    view.descField.stringValue = pkg.desc;
    
    return view;
}


-(void)openTab:(NSInteger)index {
    [self.tabView selectTabViewItemAtIndex:index];
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