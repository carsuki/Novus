//
//  AppDelegate.m
//  Novus
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation NVSAboutView

-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    self.infoField.stringValue = [NSString stringWithFormat:@"Version %@ \nCodename SwiftPoop \nBuild %@", version, build];
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
