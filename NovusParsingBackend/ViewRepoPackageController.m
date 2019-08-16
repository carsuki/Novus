//
//  ViewRepoPackageController.m
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "ViewRepoPackageController.h"

@interface ViewRepoPackageController ()

@end

@implementation ViewRepoPackageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        if (pkg.size) {
            self.size.stringValue = pkg.installedSize;
        } else {
            self.size.stringValue = @"0";
        }
        if (pkg.section) {
            self.section.stringValue = pkg.section;
        } else {
            self.section.stringValue = @"Nil";
        }
        if (pkg.homepage) {
            self.homepage.stringValue = pkg.homepage;
        } else {
            self.homepage.stringValue = @"Nil";
        }
        if (pkg.filename) {
            self.filename.stringValue = pkg.filename;
        } else {
            self.filename.stringValue = @"Nil";
        }
    }
}

@end
