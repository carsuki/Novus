//
//  NVSReplaceViewSegue.m
//  Novus
//
//  Created by EvenDev on 18/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSReplaceViewSegue.h"

@implementation NVSReplaceViewSegue

-(void)perform {
    NSViewController *source = self.sourceController;
    source.view.window.contentViewController = self.destinationController;
}

@end
