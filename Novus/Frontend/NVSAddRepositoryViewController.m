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
                newLine = [NSString stringWithFormat:@"deb %@ ./", newLine];
                [repositories addObject:newLine];
            }
        }];
        NSString *novusList = [NSString stringWithContentsOfFile:@"/usr/local/etc/apt/sources.list.d/novus.list" encoding:NSUTF8StringEncoding error:nil];
        NSString *newNovusList = [NSString new];
        newNovusList = [novusList stringByAppendingString:[NSString stringWithFormat:@"%@\n", [repositories componentsJoinedByString:@"\n"]]];
        NSError *error;
        [newNovusList writeToFile:@"/usr/local/etc/apt/sources.list.d/novus.list" atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            self.secondTitleField.stringValue = [NSString stringWithFormat:@"%@", error];
            self.secondTitleField.textColor = [NSColor systemRedColor];
        } else {
            [self.view.window.windowController close];
        }
        
        NSLog(@"add-source %@", [repositories componentsJoinedByString:@" "]);
    } else {
        self.secondTitleField.stringValue = @"Please enter one or more repositories.";
        self.secondTitleField.textColor = [NSColor systemRedColor];
    }
}

@end
