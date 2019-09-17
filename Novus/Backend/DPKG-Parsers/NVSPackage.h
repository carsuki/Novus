//
//  NVSPackage.h
//  NovusList
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Utilities/NVSCommandWrapper.h"
#import "NVSRepo.h"
#import "../Objects/NVSDepiction.h"

@interface NVSPackage : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *architecture;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *maintainer;
@property (nonatomic, strong) NSString *installedSize;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *debURL;
@property (nonatomic, strong) NSString *homepage;
@property (nonatomic, strong) NVSRepo *repository;
@property (nonatomic, strong) NSString *depictionURL;
@property (nonatomic, strong) NVSDepiction *depiction;
@property (nonatomic, strong) NSImage *icon;
@property (nonatomic) BOOL installed;

- (int)remove;
- (int)install;

@end
