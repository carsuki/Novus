//
//  NVSAddRepositoryViewController.m
//  Novus
//
//  Created by EvenDev on 27/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSAddRepositoryViewController.h"

@interface NVSAddRepositoryViewController ()

@end

@implementation NVSAddRepositoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)dismissController:(id)sender {
    [self.view.window.windowController close];
}

- (IBAction)addRepos:(id)sender {
    if (self.textview.stringValue.length > 0) {
        NSMutableArray *repositories = [[NSMutableArray alloc] init];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[self.textview.stringValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *newLine = obj;
            if (newLine.length > 2) {
                if (![newLine containsString:@"https://"]) {
                    if ([newLine containsString:@"http://"]) {
                        newLine = [newLine stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
                    } else {
                        newLine = [NSString stringWithFormat:@"https://%@", newLine];
                    }
                }
                [repositories addObject:newLine];
            }
        }];
        
        [repositories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *repo = obj;
            NSArray *distros = [repo componentsSeparatedByString:@" "];
            if (distros.count > 2) {
                [[NVSCommandWrapper sharedInstance] runAsRoot:[NSString stringWithFormat:@"nvs add-repositories -a %@", repo]];
            } else {
                [[NVSCommandWrapper sharedInstance] runAsRoot:[NSString stringWithFormat:@"nvs add-repositories %@", repo]];
            }
        }];
        
        [self.view.window.windowController close];
    } else {
        self.secondTitleField.stringValue = @"Please enter one or more repositories.";
        self.secondTitleField.textColor = [NSColor systemRedColor];
    }
}

@end
