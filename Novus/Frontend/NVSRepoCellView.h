//
//  NVSRepoCellView.h
//  Novus
//
//  Created by EvenDev on 26/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../Backend/DPKG-Parsers/NVSRepo.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVSRepoCellView : NSTableCellView

@property (strong) IBOutlet NSTextField *infoField;
@property (strong) IBOutlet NSTextField *descField;
@property (nonatomic, retain) NVSRepo *repo;

@end

NS_ASSUME_NONNULL_END
