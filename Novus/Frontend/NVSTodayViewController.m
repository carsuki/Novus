//
//  NVSTodayViewController.m
//  Novus
//
//  Created by EvenDev on 01/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSTodayViewController.h"

@interface NVSTodayViewController ()

@end

@implementation NVSTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    self.dateField.stringValue = [formatter stringFromDate:[NSDate date]];
}

@end
