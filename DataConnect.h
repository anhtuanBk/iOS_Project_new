//
//  DataConnect.h
//  iOS_Project
//
//  Created by Quyen Xuan on 4/7/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataConnect : NSObject{
    sqlite3 *db;
}

@property (strong, nonatomic) NSString *placeId;
@property (strong, nonatomic) NSString *short_desc;
@property (strong, nonatomic) NSString *thumb_img;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *adr;
@property (strong, nonatomic) NSString *full_img;
@property (strong, nonatomic) NSString *full_desc;
@property (strong, nonatomic) NSString *log;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *link;

- (NSString *) filePaths;
- (void) openDatabase;
- (NSMutableArray *) getPlaces: (NSString *)tableName;
- (void) deleteTable: (NSString *)tableName;

@end
