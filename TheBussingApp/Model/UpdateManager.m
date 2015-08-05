//
//  UpdateManager.m
//  KenoshaAreaTransit
//
//  Created by Valerie Berglind on 5/9/14.
//  Modified by Matthew Zygowicz on 9/27/2014
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import "UpdateManager.h"

@implementation UpdateManager
static sqlite3_stmt *statement = nil;

-(void)updateDatabase: (sqlite3 *) db {
    
#pragma mark Database Location
    //check current version number against remote version number
    NSString *docsDir;
    NSArray *dirPaths;
    
    NSURL *versionURL = [NSURL URLWithString:@"http://70.63.28.41/resources/data/route_version.xml"];
    //NSURL *versionURL = [NSURL URLWithString:@"131.210.52.88/[dbloc]/route_version.xml"];
    
    NSURL *updateURL = [NSURL URLWithString:@"http://70.63.28.41/resources/data/database.sql"];
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @".db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == YES) {
        const char *dbpath = [databasePath UTF8String];
    
    
        if (sqlite3_open(dbpath, &db) == SQLITE_OK) {
            int server_version = [self getRemoteVersion:versionURL];
            int user_version = [self getUserVersion:db];
            
            if( server_version > user_version){
//                NSString *queries = [self getUpdateDatabase:updateURL];
//                char *errMsg;
//                [self updateVersionNumber:server_version :db];
//                sqlite3_exec(db, [@"BEGIN EXCLUSIVE TRANSACTION" UTF8String], NULL, NULL, &errMsg);
//                sqlite3_exec(db, [queries UTF8String], NULL, NULL, &errMsg);
//                NSLog(@"%s", errMsg);
//                sqlite3_exec(db, [@"COMMIT TRANSACTION" UTF8String], NULL, NULL, &errMsg);
            }
            sqlite3_close(db);
            NSLog(@"DATABASE FINISHED!!!!!!!!!!!!!!!!!");
        }else{
            NSLog(@"Unable to open database...");
        }
        
    }else{
        NSLog(@"Unable to reach database...");
    }
}

//parse through the xml
-(int)getRemoteVersion: (NSURL *) versionURL {
    NSData *data = [[NSData alloc] initWithContentsOfURL:versionURL];
    NSError *error = nil;
    
    NSDictionary *dict = [XMLReader dictionaryForXMLData:data error:&error];
    NSLog(@"%@", dict);
    
    NSDictionary *root = dict[@"root"];
    NSDictionary *element = root[@"element"];
    NSDictionary *server_xml_version = element[@"version_number"];
    NSString *server_version = server_xml_version[@"text"];
    return  [server_version intValue];
}

-(int)getUserVersion:(sqlite3 *) db {
    NSString *querySQL = [NSString stringWithFormat:@"SELECT number FROM version_table"];
    
    const char *query_stmt = [querySQL UTF8String];
    NSLog(@"%s",query_stmt);
    if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
        NSLog(@"Error Message: %s", sqlite3_errmsg(db));
        while (sqlite3_step(statement) == SQLITE_ROW) {
            return sqlite3_column_int(statement, 0);
        }
    } else {
        NSLog(@"Something happened! %s", sqlite3_errmsg(db));
        sqlite3_reset(statement);
    }
    
    return 0;
}

-(void)updateVersionNumber:(int) version_number: (sqlite3 *) database{
    char *errMsg;
    NSString *querySQL = [NSString stringWithFormat:@"INSERT OR REPLACE INTO version_table VALUES (%d);", version_number];
    const char *sql_stmt = [querySQL UTF8String];
    if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK) {
        NSLog(@"Updated Version Number");
    }else{
        NSLog(@"Failed to update verison number...");
    }
}
- (NSString *) escapeString:(NSString *)string {
    NSRange range = NSMakeRange(0, [string length]);
    return [string stringByReplacingOccurrencesOfString:@"'" withString:@"''" options:NSCaseInsensitiveSearch range:range];
}
-(void)updateRoutes:(sqlite3 *) database: (NSDictionary *) routes{
    NSString *querySql;
    char *errMsg;
    [self deleteRouteTable:database];
    sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, &errMsg);
    for (id tempObject in routes) {
        NSDictionary *dict_id = tempObject[@"_id"];
        NSDictionary *dict_route = tempObject[@"route"];
        NSDictionary *dict_day = tempObject[@"day"];
        NSDictionary *dict_time = tempObject[@"time"];
        NSDictionary *dict_location = tempObject[@"location"];
        NSDictionary *dict_direction = tempObject[@"direction"];
        
        NSString *_id = dict_id[@"text"];
        NSString *route = dict_route[@"text"];
        NSString *time = dict_time[@"text"];
        NSString *day = dict_day[@"text"];
        NSString *location = dict_location[@"text"];
        NSString *direction = dict_direction[@"text"];
        [location stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
        location = [self escapeString:location];
        querySql = [NSString stringWithFormat:@"INSERT INTO  (`_id`, `route`, `location`, `direction`, `time`, `day`) VALUES ('%@', '%@', '%@', '%@', '%@', '%@');",_id, route, location, direction, time, day];
        const char *sql_stmt = [querySql UTF8String];
        if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK) {
//            NSLog(@"Row Inserted Successfully");
        }else{
            NSLog(@"--------ROW INSERT FAILED-------- ID=%@ : ERROR: %s", _id, sqlite3_errmsg(database));
        }
    }//end for each tempObject
    sqlite3_exec(database, "END TRANSACTION", NULL, NULL, &errMsg);
}

-(void)deleteRouteTable:(sqlite3 *) database{
    char *errMsg;
    NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM ;"];
    const char *sql_stmt = [querySQL UTF8String];
    if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK) {
        NSLog(@"Successfully removed data from ");
    }else{
        NSLog(@"Failed to remove  data...");
    }
}

-(NSString *) getUpdateDatabase: (NSURL *) updateURL{
    NSData *data = [[NSData alloc] initWithContentsOfURL:updateURL];
    NSError *error = nil;
    NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return  htmlString;
}


@end
