//
//  NVSDatabaseManager.m
//  Novus
//
//  Created by Ultra on 7/6/19.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSDatabaseManager.h"

@interface NVSDatabaseManager() {
    int connCount;
}

@property (nonatomic, strong) NSString *documentsDir;
@property (nonatomic, strong) NSString *dbFilename;

@end

@implementation NVSDatabaseManager

@synthesize database;

#pragma mark Singleton Methods

+ (id)sharedInstance {
    static NVSDatabaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithDatabaseFilename:@"novus.db"];
    });
    
    return instance;
}

- (id)initWithDatabaseFilename:(NSString *)databaseFilename {
    self = [super init];
    if(self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDir = [paths objectAtIndex:0];
        
        self.dbFilename = databaseFilename;
        
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

- (void)copyDatabaseIntoDocumentsDirectory {
    NSString *destPath = [self.documentsDir stringByAppendingPathComponent:self.dbFilename];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:destPath]) {
        // The database doesn't exist in the documents directory, so we should copy it from the bundle
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.dbFilename];
        NSError *error;
        
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destPath error:&error];
        
        if(error) {
            NSLog(@"error copying database from bundle to documents directory: %@", [error localizedDescription]);
        }
    }
}

#pragma mark Opening and Closing

- (int)openDatabase {
    NSString *databasePath = [self.documentsDir stringByAppendingPathComponent:self.dbFilename];
    if(![self isDatabaseOpen]) {
        assert(sqlite3_threadsafe());
        int result = sqlite3_open_v2([databasePath UTF8String], &database, SQLITE_OPEN_READWRITE | SQLITE_OPEN_FULLMUTEX | SQLITE_OPEN_CREATE, NULL);
        if(result == SQLITE_OK) {
            connCount++;
        }
        return result;
    } else {
        connCount++;
        return SQLITE_OK;
    }
}

- (int)closeDatabase {
    
    if(connCount == 0) {
        return SQLITE_ERROR;
    }
    
    connCount--;
    if(connCount == 0) {
        int result = sqlite3_close(database);
        database = NULL;
        if(result == SQLITE_OK) {
        }
        return result;
    }
    
    return SQLITE_OK;
}

- (BOOL)isDatabaseOpen {
    return database != NULL || connCount > 0;
}


#pragma mark Base Methods


/*
 * Returns an array of rows (which are also arrays).
 * Returns NULL if there was an error
 */
- (NSMutableArray *)executeQuery:(NSString *)query {
    if([self openDatabase] == SQLITE_OK) {
        
        sqlite3_stmt *statement;
        int result = sqlite3_prepare(database, [query UTF8String], -1, &statement, nil);
        if(result == SQLITE_OK) {
            NSMutableArray *allRows = [[NSMutableArray alloc] init];
            NSMutableArray *arrDataRow;
            
            // Loop through the results and add them to the results array row by row.
            while(sqlite3_step(statement) == SQLITE_ROW) {
                // Initialize the mutable array that will contain the data of a fetched row.
                arrDataRow = [[NSMutableArray alloc] init];
                
                // Get the total number of columns.
                int totalColumns = sqlite3_column_count(statement);
                
                // Go through all columns and fetch each column data.
                for (int i=0; i<totalColumns; i++){
                    // Convert the column data to text (characters).
                    char *dbDataAsChars = (char *)sqlite3_column_text(statement, i);
                    
                    // If there are contents in the currenct column (field) then add them to the current row array.
                    if (dbDataAsChars != NULL) {
                        // Convert the characters to string.
                        [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                    }
                }
                if(arrDataRow.count > 0) {
                    [allRows addObject:arrDataRow];
                }
            }
            
            sqlite3_finalize(statement);
            [self closeDatabase];
            return allRows;
            
        } else {
            sqlite3_finalize(statement);
            [self closeDatabase];
            NSLog(@"Failed to prepare statement while executing query: %@", query);
            return NULL;
        }
    } else {
        NSLog(@"Failed to open database while executing query: %@", query);
        return NULL;
    }
}

- (int)executeUpdate:(NSString *)update {
    if([self openDatabase] == SQLITE_OK) {
        sqlite3_stmt *statement;
        int result = sqlite3_prepare_v2(database, [update UTF8String], -1, &statement, nil);
        if(result == SQLITE_OK) {
            int updateResult = sqlite3_step(statement);
            if(updateResult == SQLITE_DONE) {
                sqlite3_finalize(statement);
                [self closeDatabase];
                return SQLITE_OK;
            } else {
                sqlite3_finalize(statement);
                [self closeDatabase];
                return SQLITE_ERROR;
            }
        } else {
            sqlite3_finalize(statement);
            [self closeDatabase];
            NSLog(@"Failed to prepare statement while executing update: %@", update);
            return SQLITE_ERROR;
        }
    } else {
        NSLog(@"Failed to open database while executing update: %@", update);
        return SQLITE_ERROR;
    }
}


#pragma mark Utility Methods


- (int)addPackageToDatabase:(NVSPackage *)package {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO packages (identifier, name, version, description, section, architecture, author, maintainer, installedSize) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", [package identifier], [package name], [package version], [package desc], [package section], [package architecture], [package author], [package maintainer], [package installedSize]];
        
    int result = [self executeUpdate:query];
    if(result == SQLITE_OK) {
        return SQLITE_OK;
    } else {
        NSLog(@"Error adding package to database");
        return SQLITE_ERROR;
    }
}

- (int)removePackageFromDatabase:(NVSPackage *)package {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM packages WHERE identifier = %@", [package identifier]];
        
    int result = [self executeUpdate:query];
    if(result == SQLITE_OK) {
        return SQLITE_OK;
    } else {
        NSLog(@"Error removing package from database");
        return SQLITE_ERROR;
    }
}

- (int)removePackageFromDatabaseByIdentifier:(NSString *)identifier {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM packages WHERE identifier = '%@';", identifier];
        
    int result = [self executeUpdate:query];
    if(result == SQLITE_OK) {
        return SQLITE_OK;
    } else {
        NSLog(@"Error removing package from database by identifier: %@", identifier);
        return SQLITE_ERROR;
    }
}

- (int)purgeAllPackagesFromDatabase {
    NSString *query = @"DELETE FROM packages;";
        
    int result = [self executeUpdate:query];
    if(result == SQLITE_OK) {
        NSLog(@"All packages were purged from the database!");
        return SQLITE_OK;
    } else {
        NSLog(@"Error purging all packages from database");
        return SQLITE_ERROR;
    }
}

- (NVSPackage *)getPackageFromDatabaseByIdentifier:(NSString *)identifier {
        
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM packages WHERE identifier = '%@';", identifier];
        
    NSMutableArray *results = [self executeQuery:query];
    if(results != NULL) {
        NSMutableArray *packageAsArray = [results objectAtIndex:0];
        NVSPackage *package = [[NVSPackage alloc] init];
        package.identifier = [packageAsArray objectAtIndex:0];
        package.name = [packageAsArray objectAtIndex:1];
        package.version = [packageAsArray objectAtIndex:2];
        package.desc = [packageAsArray objectAtIndex:3];
        package.section = [packageAsArray objectAtIndex:4];
        package.architecture = [packageAsArray objectAtIndex:5];
        package.author = [packageAsArray objectAtIndex:6];
        package.maintainer = [packageAsArray objectAtIndex:7];
        package.installedSize = [packageAsArray objectAtIndex:8];
        return package;
    } else {
        NSLog(@"Could not get package from database by identifier: %@ - There was an error, or the package does not exist.", identifier);
        return NULL;
    }
    
}

@end
