//
//  ViewInstalledPackageController.m
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "ViewInstalledPackageController.h"

@interface ViewInstalledPackageController ()

@end

@implementation ViewInstalledPackageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NVSPackage *pkg = self.package;
    if (pkg) {
        if (pkg.name) {
            self.titleField.stringValue = pkg.name;
            self.title = pkg.name;
        } else {
            self.titleField.stringValue = pkg.identifier;
            self.title = pkg.identifier;
        }
        if (pkg.identifier) {
            self.packageID.stringValue = pkg.identifier;
        } else {
            self.packageID.stringValue = @"Nil";
        }
        if (pkg.version) {
            self.version.stringValue = pkg.version;
        } else {
            self.version.stringValue = @"Nil";
        }
        if (pkg.desc) {
            self.desc.stringValue = pkg.desc;
        } else {
            self.desc.stringValue = @"Nil";
        }
        if (pkg.architecture) {
            self.architecture.stringValue = pkg.architecture;
        } else {
            self.architecture.stringValue = @"Nil";
        }
        if (pkg.author) {
            self.author.stringValue = pkg.author;
        } else {
            self.author.stringValue = @"Nil";
        }
        if (pkg.maintainer) {
            self.maintainer.stringValue = pkg.maintainer;
        } else {
            self.maintainer.stringValue = @"Nil";
        }
        if (pkg.installedSize) {
            self.installedSize.stringValue = pkg.installedSize;
        } else {
            self.installedSize.stringValue = @"0";
        }
        if (pkg.section) {
            self.section.stringValue = pkg.section;
        } else {
            self.section.stringValue = @"Nil";
        }
    }
}

@end
