//
//  NVSSearchViewController.m
//  Novus
//
//  Created by EvenDev on 06/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSSearchViewController.h"

@interface NVSSearchViewController ()

@end

@implementation NVSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.results = [NSMutableArray arrayWithArray:[[[NVSPackageManager sharedInstance] packagesArray] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"identifier contains[cd] %@", self.searchQuery]]];
    self.titleField.stringValue = self.searchQuery;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.results.count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSPackageCellView *view = [tableView makeViewWithIdentifier:@"PackageCell" owner:self];
    NVSPackage *pkg = [self.results objectAtIndex:row];
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
    
    return view;
}

@end
