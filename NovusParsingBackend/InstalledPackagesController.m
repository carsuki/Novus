//
//  InstalledPackagesController.m
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "InstalledPackagesController.h"

@interface InstalledPackagesController ()

@end

@implementation InstalledPackagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.parser = [[LMPackageParser alloc] initWithFilePath:@"/usr/local/var/lib/dpkg/status"];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.parser.packages.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSPackage *pkg = [self.parser.packages objectAtIndex:row];
    if (pkg.name) {
        return pkg.name;
    } else {
        return pkg.identifier;
    }
}

-(BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    [self performSegueWithIdentifier:@"openInstalledPackage" sender:self];
    return NO;
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    ViewInstalledPackageController *destController = segue.destinationController;
    NVSPackage *pkg = [self.parser.packages objectAtIndex:self.tableView.selectedRow];
    destController.package = pkg;
}

@end
