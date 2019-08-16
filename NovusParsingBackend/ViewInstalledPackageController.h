//
//  ViewInstalledPackageController.h
//  NovusParsingBackend
//
//  Created by EvenDev on 16/08/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NVSPackage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewInstalledPackageController : NSViewController

@property (strong) IBOutlet NSTextField *titleField;
@property (nonatomic, retain) NVSPackage *package;

@property (strong) IBOutlet NSTextField *packageID;
@property (strong) IBOutlet NSTextField *version;
@property (strong) IBOutlet NSTextField *desc;
@property (strong) IBOutlet NSTextField *architecture;
@property (strong) IBOutlet NSTextField *author;
@property (strong) IBOutlet NSTextField *maintainer;
@property (strong) IBOutlet NSTextField *installedSize;
@property (strong) IBOutlet NSTextField *section;

@end

NS_ASSUME_NONNULL_END
