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
        // Remove
        NVSQueueAction *action = [[NVSQueueAction alloc] initWithPackage:self.package action:1];
        [[NVSQueue sharedInstance] addQueueAction:action];
        [self showQueuePopup:action];
    } else {
        // Install
        NVSQueueAction *action = [[NVSQueueAction alloc] initWithPackage:self.package action:0];
        [[NVSQueue sharedInstance] addQueueAction:action];
        [self showQueuePopup:action];
    }
}

-(void)showQueuePopup:(NVSQueueAction*)action {
    NSView *view = [[NSView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height - 46, 280, 30)];
    view.wantsLayer = YES;
    view.layer.backgroundColor = [NSColor colorWithRed:0.48 green:0.93 blue:0.62 alpha:1].CGColor;
    view.layer.cornerRadius = 6;
    NSTextField *label = [[NSTextField alloc] initWithFrame:CGRectMake(7, 4, 266, 20)];
    [label setStringValue:[NSString stringWithFormat:@"✓  Successfully added %@ to the queue", action.package.identifier]];
    [label setTextColor:[NSColor whiteColor]];
    [label setFont:[NSFont boldSystemFontOfSize:label.font.pointSize]];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setEditable:NO];
    [label setSelectable:NO];
    [view addSubview:label];
    [self.view addSubview:view];
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.1;
        view.animator.frame = CGRectMake(self.view.frame.size.width - 296, self.view.frame.size.height - 46, 280, 30);
    }];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
            context.duration = 0.1;
            view.animator.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height - 46, 200, 30);
        }];
    });
}

- (IBAction)openHomepage:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:self.package.homepage]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.box.frame = CGRectOffset(self.box.frame, self.view.frame.size.width, 0);
    if (@available(macOS 10.12, *)) {
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
            context.duration = 0.3;
            self.box.animator.frame = CGRectOffset(self.box.frame, -self.view.frame.size.width, 0);
        }];
    } else {
        self.box.frame = CGRectOffset(self.box.frame, -self.view.frame.size.width, 0);
    }
    
    NVSPackage *pkg = self.package;
    if (self.package) {
        // If it doesn't have a novus depiction
        if (pkg.installed) {
            self.getButtonTitle.stringValue = @"REMOVE";
        }
        if (!pkg.depiction) {
            if (pkg.homepage) {
                self.developerSiteButton.enabled = YES;
            }
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
            if (pkg.icon) {
                self.packageIcon.image = pkg.icon;
            }
            if (pkg.identifier) {
                self.informationIdentifier.stringValue = pkg.identifier;
            }
        }
    }
}

@end
