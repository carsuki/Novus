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
    
    self.parser = [[LMPackageParser alloc] initWithFilePath:@"/usr/local/var/lib/dpkg/status"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.parser.packages.count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSPackageCellView *view = [tableView makeViewWithIdentifier:@"PackageCell" owner:self];
    NVSPackage *pkg = [self.parser.packages objectAtIndex:row];
    if (pkg.name) {
        view.textField.stringValue = pkg.name;
    } else {
        view.textField.stringValue = pkg.identifier;
    }
    NSArray *maintainer = [pkg.maintainer componentsSeparatedByString:@"<"];
    view.maintainerField.stringValue = [maintainer objectAtIndex:0];
    view.descField.stringValue = pkg.desc;
    //view.descField.stringValue = pkg.desc;
    
    return view;
}

@end
