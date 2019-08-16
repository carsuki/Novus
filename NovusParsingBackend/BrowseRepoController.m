//
//  BrowseRepoController.m
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "BrowseRepoController.h"

@interface BrowseRepoController ()

@end

@implementation BrowseRepoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.titleField.stringValue = self.repo.label;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.repo.packages.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSPackage *pkg = [self.repo.packages objectAtIndex:row];
    if (pkg.name && pkg.name.length > 0) {
        return pkg.name;
    } else {
        if (pkg.identifier) {
            return pkg.identifier;
        } else {
            return @"Unknown";
        }
    }
}

-(BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    [self performSegueWithIdentifier:@"openRepoPackage" sender:self];
    return NO;
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    NVSPackage *pkg = [self.repo.packages objectAtIndex:self.tableView.selectedRow];
    ViewRepoPackageController *destController = segue.destinationController;
    destController.package = pkg;
}

@end
