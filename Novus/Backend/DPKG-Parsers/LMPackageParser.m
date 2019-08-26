//
//  LMPackageParser.m
//  Lime
//
//  Created by ArtikusHG on 7/25/19.
//  Copyright © 2019 Daniel. All rights reserved.
//

#import "LMPackageParser.h"
#import "NVSPackage.h"
@import AppKit;

@implementation LMPackageParser

- (instancetype)initWithFilePath:(NSString *)filePath {
    
    // TOREMOVE
    self = [super init];
    NSLog(@"init parser");
    NVSPackage *package = [[NVSPackage alloc] init];
    FILE *f = fopen([filePath UTF8String], "r");
    char str[1024];
    NSMutableArray *mutablePackages = [[NSMutableArray alloc] init];

    NSDictionary *customPropertiesDict = @{
        @"package":@"identifier",
        @"name":@"name",
        @"version":@"version",
        @"description":@"desc",
        @"architecture":@"architecture",
        @"author":@"author",
        @"maintainer":@"maintainer",
        @"size":@"size",
        @"section":@"section",
        @"filename":@"filename",
        @"homepage":@"homepage",
        @"installed-size":@"installedSize"
    };
	
    NSString *lastKey = nil;
    while(fgets(str, sizeof(str), f) != NULL) {
        if(!str[1] && ![package.identifier hasPrefix:@"cy+"] && ![package.identifier hasPrefix:@"gsc."]) { // a line THAT short is obviously a newline, and we wanna go to the next package and add the current one if so; also we don't add packages prefixed with gsc and cy+
            if(package.name.length < 1) package.name = package.identifier;
            [mutablePackages addObject:package];
            // reset it
            package = nil;
            package = [[NVSPackage alloc] init];
            lastKey = nil;
            //break;
        } else {
            NSString *line = [[NSString stringWithCString:str encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            if(line.length && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[line characterAtIndex:0]]) {
            	// multiline descriptions
                NSString *nextLine = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // remove 4 spaces
                NSString *oldValue = [package valueForKey:lastKey];
                [package setValue:[NSString stringWithFormat:@"%@%@", (oldValue ? [oldValue stringByAppendingString:@"\n"] : @""), nextLine] forKey:lastKey];
            }
            else if([line containsString:@": "]) {
                NSMutableArray *lineArray = [line componentsSeparatedByString:@": "].mutableCopy; // Separate the line into the key and the value
                // initialize the key as the lowercase dpkg key (lowercase because see next comment)
                NSString *key = [[lineArray objectAtIndex:0] lowercaseString];
                // LMPackage has custom property names (e.g. description would be desc, dependencies would be depends etc.) so if there is a custom property name set for the current key in our dictionary we change the key
                if([customPropertiesDict objectForKey:key]) key = [customPropertiesDict objectForKey:key];
                // the value (most useless comment in the world)
                [lineArray removeObjectAtIndex:0];
                NSString *value = [lineArray componentsJoinedByString:@": "];
                if(key && value && [package respondsToSelector:NSSelectorFromString(key)]) {
                    [package setValue:value forKey:(lastKey = key)];
                }
			}
        }
    }
    
    fclose(f);
    self.packages = [mutablePackages copy];
    //UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"a" message:[NSString stringWithFormat:@"%@",self.packages] delegate:nil cancelButtonTitle:@"a" otherButtonTitles:nil];
    //[a show];
    NSLog(@"Got %ld package(s) from %@", (long)self.packages.count, filePath);
    return self;
}

@end
