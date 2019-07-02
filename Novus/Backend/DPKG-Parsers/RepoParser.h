//
//  LMDPKGParser.h
//  Lime
//
//  Created by EvenDev on 7/1/19.
//  Copyright © 2019 EvenDev. All rights reserved.
//

//  Special thanks to the Lime team for providing the DPKG parser files, Lime team is complety credited and their Twitter can be found here: https://twitter.com/limeinstaller.

//  Lime is a package manager for Jailbroken iOS devices.
//  Original file: LMDPKGParser.h, HEAVILY modified by EvenDev to make it work.

#import <Foundation/Foundation.h>
#import "NVSRepo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepoParser : NSObject

@property (strong, nonatomic) NSMutableArray *addedRepositories;
@property (strong, nonatomic) NSMutableArray *tempRepo;

@end

NS_ASSUME_NONNULL_END
