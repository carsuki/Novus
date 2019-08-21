//
//  NVSDatabaseManager.h
//  Novus
//
//  Created by Ultra on 7/6/19.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#ifndef NVSDatabaseManager_h
#define NVSDatabaseManager_h

#import <sqlite3.h>
#import "../DPKG-Parsers/NVSPackage.h"

@interface NVSDatabaseManager : NSObject

// A reference to the sqlite3 database
@property (atomic) sqlite3 *database;

+ (id)sharedInstance;
- (NSMutableArray *)executeQuery:(NSString *)query;
- (int)executeUpdate:(NSString *)update;
- (int)addPackageToDatabase:(NVSPackage *)package;
- (int)removePackageFromDatabase:(NVSPackage *)package;
- (int)removePackageFromDatabaseByIdentifier:(NSString *)identifier;
- (int)purgeAllPackagesFromDatabase;
- (NVSPackage *)getPackageFromDatabaseByIdentifier:(NSString *)identifier;
- (BOOL)isDatabaseOpen;

@end


#endif /* NVSDatabaseManager_h */
