//
//  NVSBrowseRepoViewController.m
//  Novus
//
//  Created by EvenDev on 01/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSBrowseRepoViewController.h"

@interface NVSBrowseRepoViewController ()

@end

@implementation NVSBrowseRepoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.titleField.stringValue = self.repo.label;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    self.dateLabel.stringValue = [formatter stringFromDate:[NSDate date]];
    
    self.box.frame = CGRectOffset(self.box.frame, self.view.frame.size.width, 0);
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.3;
        self.box.animator.frame = CGRectOffset(self.box.frame, -self.view.frame.size.width, 0);
    }];
}

- (IBAction)dismiss:(id)sender {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.15;
        self.box.animator.frame = CGRectOffset(self.box.frame, self.view.frame.size.width, 0);
    } completionHandler:^{
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.repo.packages.count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSPackageCellView *view = [tableView makeViewWithIdentifier:@"PackageCell" owner:self];
    NVSPackage *pkg = [self.repo.packages objectAtIndex:row];
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
