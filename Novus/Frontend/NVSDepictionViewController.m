//
//  NVSDepictionViewController.m
//  Novus
//
//  Created by EvenDev on 12/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSDepictionViewController.h"

@interface NVSDepictionViewController ()

@end

@implementation NVSDepictionViewController

- (IBAction)dismiss:(id)sender {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.15;
        self.box.animator.frame = CGRectOffset(self.box.frame, self.view.frame.size.width, 0);
    } completionHandler:^{
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}

- (IBAction)action:(id)sender {
    if (self.package.installed) {
        [self.package remove];
    } else {
        [self.package install];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.box.frame = CGRectOffset(self.box.frame, self.view.frame.size.width, 0);
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.3;
        self.box.animator.frame = CGRectOffset(self.box.frame, -self.view.frame.size.width, 0);
    }];
    
    NVSPackage *pkg = self.package;
    if (self.package) {
        // If it doesn't have a novus depiction
        if (pkg.installed) {
            self.getButtonTitle.stringValue = @"REMOVE";
        }
        if (!pkg.depiction) {
            if (pkg.name) {
                self.packageName.stringValue = pkg.name;
            } else {
                self.packageName.stringValue = pkg.identifier;
            }
            if (pkg.maintainer) {
                NSArray *maintainer = [pkg.maintainer componentsSeparatedByString:@"<"];
                self.packageMaintainer.stringValue = [maintainer objectAtIndex:0];
            }
            if (pkg.repository) {
                self.packageRepo.stringValue = pkg.repository.label;
            } else {
                self.packageRepo.stringValue = @"Local";
            }
            if (pkg.desc) {
                self.packageDescription.stringValue = pkg.desc;
                [self.packageDescription sizeToFit];
            }
            self.packageDescription.frame = CGRectMake(self.packageDescription.frame.origin.x, self.packageIcon.frame.origin.y - 20 - self.packageDescription.frame.size.height, self.packageDescription.frame.size.width, self.packageDescription.frame.size.height);
            
            self.previewScrollview.frame = CGRectZero;
            self.packageReviewCount.frame = CGRectZero;
            self.packageReviewScore.frame = CGRectZero;
            self.ratingsView.frame = CGRectZero;
            self.latestUpdateView.frame = CGRectZero;
            
            self.informationView.frame = CGRectMake(self.packageDescription.frame.origin.x, self.packageDescription.frame.origin.y - 20 - self.informationView.frame.size.height, self.informationView.frame.size.width, self.informationView.frame.size.height);
            self.scrollView.documentView.frame = self.view.frame;
            self.scrollView.hasVerticalScroller = NO;
            
            if (pkg.maintainer) {
                NSArray *maintainer = [pkg.maintainer componentsSeparatedByString:@"<"];
                self.informationMaintainer.stringValue = [maintainer objectAtIndex:0];
            }
            if (pkg.version) {
                self.informationVersion.stringValue = pkg.version;
            }
            if (pkg.repository) {
                self.informationRepository.stringValue = pkg.repository.label;
            } else {
                self.informationRepository.stringValue = @"Local";
            }
            if (pkg.size) {
                self.informationSize.stringValue = pkg.size;
            }
            if (pkg.section) {
                self.informationCategory.stringValue = [pkg.section stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[pkg.section substringToIndex:1] uppercaseString]];
            }
            if (pkg.identifier) {
                self.informationIdentifier.stringValue = pkg.identifier;
            }
        }
    }
}

@end
