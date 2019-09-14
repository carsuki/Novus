//
//  NVSCommandWrapper.m
//  Novus
//
//  Created by Ultra on 7/30/19.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSCommandWrapper.h"
#import "debug.h"

@implementation NVSCommandWrapper

#pragma mark Singleton sharedInstance

+(id)sharedInstance {
    static NVSCommandWrapper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark Main methods

// Returns an NSArray with the stdout data at index 0 and the stderr data at index 1
-(NSArray *)runAsUser:(NSString *)commandWithArgs {
    NSString *taskCommand = @"/bin/zsh";
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = taskCommand;
    NSMutableArray *args = [NSMutableArray arrayWithObjects:commandWithArgs, nil];
    [args insertObject:@"-l" atIndex:0];
    [args insertObject:@"-c" atIndex:1];
    task.arguments = args;
    
    NSPipe *stdoutPipe = [NSPipe pipe];
    task.standardOutput = stdoutPipe;
    NSPipe *stderrPipe = [NSPipe pipe];
    task.standardError = stderrPipe;
    
    NSFileHandle *stdoutFile = stdoutPipe.fileHandleForReading;
    NSFileHandle *stderrFile = stderrPipe.fileHandleForReading;
    
    NSLog(@"about to run %@ as user", commandWithArgs);
    
    [task launch];
    
    NSData *stdoutData = [stdoutFile readDataToEndOfFile];
    [stdoutFile closeFile];
    NSData *stderrData = [stderrFile readDataToEndOfFile];
    [stderrFile closeFile];
    
    NSArray *ret = [NSArray arrayWithObjects:stdoutData, stderrData, nil];
    
    DEBUGLOG("command run as user: %@\nstdout:\n%@\nstderr:\n%@\n", commandWithArgs, [[NSString alloc] initWithData:stdoutData encoding:NSUTF8StringEncoding], [[NSString alloc] initWithData:stderrData encoding:NSUTF8StringEncoding]);
    
    return ret;
}

// Returns true if becoming root works, and false otherwise
-(BOOL)checkRoot {
    NSString *taskCommand = @"/Applications/Novus.app/Contents/MacOS/redchain";
    
    // Check if binary exists, returned an error before.
    if ([[NSFileManager defaultManager] fileExistsAtPath:taskCommand]) {
        NSArray *args = [NSArray arrayWithObjects:@"whoami", nil];
        NSTask *task = [[NSTask alloc] init];
        task.launchPath = taskCommand;
        task.arguments = args;
        
        NSPipe *stdoutPipe = [NSPipe pipe];
        task.standardOutput = stdoutPipe;
        NSPipe *stderrPipe = [NSPipe pipe];
        task.standardError = stderrPipe;
        
        NSFileHandle *stdoutFile = stdoutPipe.fileHandleForReading;
        NSFileHandle *stderrFile = stderrPipe.fileHandleForReading;
        
        [task launch];
        
        NSData *stdoutData = [stdoutFile readDataToEndOfFile];
        [stdoutFile closeFile];
        NSData *stderrData = [stderrFile readDataToEndOfFile];
        [stderrFile closeFile];
        
        NSString *response = [[NSString alloc] initWithData:stdoutData encoding:NSUTF8StringEncoding];
        if([response isEqualToString:@"root\n"]) {
            // NSLog(@"We have root");
            return true;
        } else {
            NSString *stderrStr = [[NSString alloc] initWithData:stderrData encoding:NSUTF8StringEncoding];
            NSLog(@"Obtaining root failed\nstdout:\n%@\nstderr:\n%@", response, stderrStr);
            return false;
        }
    } else {
        NSLog(@"%@ does not exist. Failed to get root.", taskCommand);
        return false;
    }
}

// Returns an NSArray with the stdout data at index 0, the stderr data at index 1, or NULL if getting root failed.
-(NSArray *)runAsRoot:(NSString *)commandWithArgs {
    if([self checkRoot]) {
        NSString *taskCommand = @"/Applications/Novus.app/Contents/MacOS/redchain";
        NSArray *args = [NSArray arrayWithObjects:commandWithArgs, nil];
        NSTask *task = [[NSTask alloc] init];
        task.launchPath = taskCommand;
        task.arguments = args;
        
        NSPipe *stdoutPipe = [NSPipe pipe];
        task.standardOutput = stdoutPipe;
        NSPipe *stderrPipe = [NSPipe pipe];
        task.standardError = stderrPipe;
        
        NSFileHandle *stdoutFile = stdoutPipe.fileHandleForReading;
        NSFileHandle *stderrFile = stderrPipe.fileHandleForReading;
        
        NSLog(@"about to run %@ as root", commandWithArgs);
        
        [task launch];
        [task waitUntilExit];
        
        NSLog(@"reading stdout and stderr data");
        
        NSData *stdoutData = [stdoutFile readDataToEndOfFile];
        [stdoutFile closeFile];
        NSData *stderrData = [stderrFile readDataToEndOfFile];
        [stderrFile closeFile];
        
        NSArray *ret = [NSArray arrayWithObjects:stdoutData, stderrData, nil];
        
        DEBUGLOG("command run as root: %@\nstdout:\n%@\nstderr:\n%@\n", commandWithArgs, [[NSString alloc] initWithData:stdoutData encoding:NSUTF8StringEncoding], [[NSString alloc] initWithData:stderrData encoding:NSUTF8StringEncoding]);
        
        return ret;
    } else {
        NSLog(@"Failed to obtain root while running command: %@", commandWithArgs);
        return NULL;
    }
}

@end

