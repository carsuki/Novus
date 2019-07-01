//
//  AppDelegate.h
//  Novus
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>


@end

@interface NVSAboutView : NSViewController

@property (strong) IBOutlet NSTextField *infoField;

@end

