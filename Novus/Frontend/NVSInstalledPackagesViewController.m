//
//  NVSInstalledPackagesViewController.m
//  Novus
//
//  Created by EvenDev on 21/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSInstalledPackagesViewController.h"

@interface NVSInstalledPackagesViewController ()

@end

@implementation NVSInstalledPackagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    self.dateLabel.stringValue = [formatter stringFromDate:[NSDate date]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[NVSPackageManager sharedInstance] installedPackagesArray].count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSPackageCellView *view = [tableView makeViewWithIdentifier:@"PackageCell" owner:self];
    NVSPackage *pkg = [[[NVSPackageManager sharedInstance] installedPackagesArray] objectAtIndex:row];
    if (pkg.name) {
        view.textField.stringValue = pkg.name;
    } else {
        view.textField.stringValue = pkg.identifier;
    }
    if (pkg.maintainer) {
        NSArray *maintainer = [pkg.maintainer componentsSeparatedByString:@"<"];
        view.maintainerField.stringValue = [maintainer objectAtIndex:0];
    }
    if (pkg.desc) {
        view.descField.stringValue = pkg.desc;
    }
    if (pkg.icon) {
        view.imageView.image = pkg.icon;
    }
    
    return view;
}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    ViewController *parent = self.parentViewController;
    NVSPackage *selPkg = [[[NVSPackageManager sharedInstance] installedPackagesArray] objectAtIndex:row];
    [parent viewPackage:[[[NVSPackageManager sharedInstance] packagesDict] objectForKey:selPkg.identifier]];
    return NO;
}

@end
