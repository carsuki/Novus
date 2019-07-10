//
//  NVSPackage.h
//  NovusList
//
//  Created by EvenDev on 30/06/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVSPackage : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) NSString *architecture;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *maintainer;
@property (nonatomic, strong) NSString *installedSize;
@property (nonatomic, strong) NSString *repoUrl;

- (id)initWithIdentifier:(NSString *)identifier name:(NSString *)name version:(NSString *)version description:(NSString *)desc section:(NSString *)section architecture:(NSString *)arch author:(NSString *)author maintainer:(NSString *)maintainer installedSize:(NSString *)size repoUrl:(NSString *)repoUrl;

@end
