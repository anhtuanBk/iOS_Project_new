//
//  DataConnect.m
//  iOS_Project
//
//  Created by Quyen Xuan on 4/7/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import "DataConnect.h"
#import "Places.h"

@implementation DataConnect

@synthesize placeId;
@synthesize short_desc;
@synthesize thumb_img;
@synthesize name;
@synthesize type;
@synthesize adr;
@synthesize full_img;
@synthesize full_desc;
@synthesize log;
@synthesize lat;
@synthesize link;

// Path to sqlite database file
- (NSString *) filePaths{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"db.db"];
    //NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"db.db"];
    //return path;
}

- (void) openDatabase{
    if (sqlite3_open([[self filePaths] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
    }
}

// Return an array of Locations
- (NSMutableArray *) getPlaces:(NSString *)tableName{
    sqlite3_stmt *stm;
    Places *place;
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@'", tableName];
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stm, nil) == SQLITE_OK){
        while (sqlite3_step(stm) == SQLITE_ROW) {
            place = [[Places alloc] init];
            place.placeId = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stm, 0)];
            place.short_desc = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 1)];
            place.thumb_img = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 2)];
            place.name = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 3)];
            place.type = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 4)];
            place.adr = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 5)];
            place.full_img = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 6)];
            place.full_desc = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 7)];
            place.log = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 8)];
            place.lat = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 9)];
            place.link = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(stm, 10)];
            [entries addObject:place];
        }
    }
    return entries;
}

- (void) deleteTable:(NSString *)tableName{
    char *err;
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE '%@'", tableName];
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
    }
}

@end
