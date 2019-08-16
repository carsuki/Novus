//
//  LMDPKGParser.h
//  Lime
//
//  Created by ArtikusHG on 4/30/19.
//  Copyright © 2019 Daniel. All rights reserved.
//

//  Special thanks to the Lime team for providing the DPKG parser files, Lime team is complety credited and their Twitter can be found here: https://twitter.com/limeinstaller.

//  Lime is a package manager for Jailbroken iOS devices.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LMDPKGParser : NSObject

@property (strong, nonatomic) NSMutableArray *installedPackages;

@end

NS_ASSUME_NONNULL_END
