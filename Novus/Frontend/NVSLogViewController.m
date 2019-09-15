//
//  NVSLogViewController.m
//  Novus
//
//  Created by EvenDev on 15/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSLogViewController.h"

@interface NVSLogViewController ()

@end

@implementation NVSLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.command = [[NSUserDefaults standardUserDefaults] valueForKey:@"command"];
    [self runCommand:self.command];
}

-(void)runCommand:(NSString *)command {
    NSString *taskCommand = @"/Applications/Novus.app/Contents/MacOS/redchain";
    NSArray *args = [NSArray arrayWithObjects:command, nil];
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = taskCommand;
    task.arguments = args;
    
    task.terminationHandler = ^(NSTask *task){
        self.logView.string = [self.logView.string stringByAppendingString:@"\nDone."];
    };
    
    NSMutableDictionary *defaultEnv = [[NSMutableDictionary alloc] initWithDictionary:[[NSProcessInfo processInfo] environment]];
    [defaultEnv setObject:@"YES" forKey:@"NSUnbufferedIO"] ;
    task.environment = defaultEnv;
    
    NSPipe *stdoutPipe = [NSPipe pipe];
    task.standardOutput = stdoutPipe;
    [[task.standardOutput fileHandleForReading] setReadabilityHandler:^(NSFileHandle *file) {
        NSData *data = [file availableData];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.logView.string = [self.logView.string stringByAppendingString:string];
            [self.logView scrollRangeToVisible:NSMakeRange(self.logView.string.length, 0)];
        });
    }];
    NSPipe *stderrPipe = [NSPipe pipe];
    task.standardError = stderrPipe;
    
    NSLog(@"about to run %@ as root", command);
    
    [task launch];
}

@end
