//
//  DatabaseManager.h
//  KenoshaAreaTransit
//
//  DatabaseManager builds and queries a local sqlite3 database.  The database
//  will house the route information, including a unique identifier (_id), a time,
//  a direction, a stop name, a route number and whether or not the time is on a
//  weekday or weekend.
//
//  Created by Richard Lebbin on 3/19/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import "DatabaseManager.h"
#import "ConnectionManager.h"
#import "Constants.h"

static DatabaseManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
NSDictionary *resultDict = nil;

@implementation DatabaseManager

+(DatabaseManager*)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(sqlite3 *)get_database{
    return database;
}

+(NSString *)validateValue:(NSString *)query{
    NSRange range = [query rangeOfString:@"="];
    if (range.location == NSNotFound) {
        return @"unsafe";
    }else{
        
    }
    return [query substringFromIndex:range.location+1];
}

// XXX: Database must be implemented in such a way to allow for versioning and
//      updating
-(BOOL)createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @".db"]];
    
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        char *errMsg;
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            //@TODO call create database
            NSString *filepath = [Constants getDBName];
            NSString *fileRoot = [[NSBundle mainBundle]pathForResource:filepath ofType:@"sql"];
            NSString *fileContents = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
            //            NSLog(fileContents);
            [self create__version_db];
            sqlite3_exec(database, [@"BEGIN EXCLUSIVE TRANSACTION" UTF8String], NULL, NULL, &errMsg);
            sqlite3_exec(database, [fileContents UTF8String], NULL, NULL, &errMsg);
            NSLog(@"%s", errMsg);
            sqlite3_exec(database, [@"COMMIT TRANSACTION" UTF8String], NULL, NULL, &errMsg);
            //            sqlite3_finalize([@"end work" UTF8String]);
            sqlite3_close(database);
            //            sqlite3_finalize(<#sqlite3_stmt *pStmt#>)
            //            NSLog(errMsg);
            //            }
        } else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
        
    } else{
        //database already exists, we check for updates.
        
    }
    NSLog(@"Successful Connection");
    return isSuccess;
}
-(BOOL) create__version_db{
    char *errMsg;
    BOOL isSuccess = YES;
    const char *sql_stmt = "create table if not exists version_table ('number' int(4) NOT NULL);";
    if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
        isSuccess = NO;
        NSLog(@"Failed to create version_table");
    }else
        NSLog(@"Successful Creation");
    return isSuccess;
}
//-(void) drop__db{
//    char *errMsg;
//    const char *sql_drop = "drop table if exists ;";
//    int ok = sqlite3_exec(database, sql_drop, NULL, NULL, &errMsg);
//    if (ok == SQLITE_OK) {
//        NSLog(@"Table Dropped!");
//    } else {
//        NSLog(@"Table not dropped!");
//    }
//}
//@TODO Read from FIle and exec
-(BOOL) create__db{
    char *errMsg;
    BOOL isSuccess = YES;
    //
    //    NSString *sql_stmtV = @"create table if not exists  ( _id int (4), route int (2), location varchar (32), day varchar (10), time int (4), direction varchar (6) );";
    //    const char *sql_stmt = [sql_stmtV UTF8String];
    //    if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
    //        isSuccess = NO;
    //        NSLog(@"Failed to create _table");
    //    } else {
    //        if (self.initialize) {
    //            NSLog(@"Table not created!");
    //        } else {
    //            NSLog(@"Table created!");
    //        }
    //
    //    }
    //    NSLog(@"Successful Creation");
    return isSuccess;
}

- (NSMutableArray*) getTimeAndRoute:(NSString *)QRData time:(NSString *)_time day:(NSString *)_day{
    const char *dbpath = [databasePath UTF8String];
    
    int rows = 0;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSLog(@"%@ %@",QRData, _time);
        NSString *valStr = [DatabaseManager validateValue:QRData];
        if (strcmp([valStr UTF8String], "unsafe") == 0) {
            return nil;
        }
        
        NSString *querySQL;
        
        //Working code
        //        querySQL = [NSString stringWithFormat:@"SELECT * FROM (SELECT k1.route route, k1.direction direction, k1.location location, (SELECT case when MIN(k2.time) != '' then MIN(k2.time) else (9999) end FROM  k2 WHERE k1.route = k2.route AND k2.direction =k1.direction AND k1._id=k2._id AND k1.location=k2.location AND k2.time > %@ ) time FROM  k1 WHERE k1.location = \"%@\" and k1.day = '%@' ORDER BY time desc ) as k GROUP BY k.route, k.direction;",_time,valStr,_day];
        
        NSDate *now = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"cccc"];
        NSString *day = [[dateFormatter stringFromDate:now] lowercaseString];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        
        //        querySQL = [NSString stringWithFormat:@"SELECT   s.stop_name stop_name,  st.stop_sequence stop_sequence,  st.stop_id stop_id,  st.arrival_time arrival_time,  st.departure_time departure_time,  st.trip_id trip_id,  r.route_id route_id,  r.route_color route_color,  r.route_text_color route_text_color FROM  stop_times st   LEFT OUTER JOIN  stops s ON st.stop_id = s.stop_id  LEFT OUTER JOIN   trips t ON st.trip_id = t.trip_id  LEFT OUTER JOIN   routes r ON t.route_id = r.route_id  LEFT OUTER JOIN   calendar c ON t.service_id = c.service_id WHERE  st.stop_id = \"%@\"  AND  c.%@ = '1'  AND  r.is_deleted = 0  AND   t.is_deleted = 0 AND st.arrival_time > \"%@\" ORDER BY st.stop_sequence", valStr, day, [formatter stringFromDate:[NSDate date]]];
        querySQL = [NSString stringWithFormat:@"SELECT * FROM (SELECT   s.stop_name stop_name,  st.stop_sequence stop_sequence,  st.stop_id stop_id,  st.arrival_time arrival_time,  st.departure_time departure_time,  st.trip_id trip_id,  r.route_id route_id,  r.route_color route_color,  r.route_text_color route_text_color, c.service_id service_id FROM  stop_times st   LEFT OUTER JOIN  stops s ON st.stop_id = s.stop_id  LEFT OUTER JOIN   trips t ON st.trip_id = t.trip_id  LEFT OUTER JOIN   routes r ON t.route_id = r.route_id  LEFT OUTER JOIN   calendar c ON t.service_id = c.service_id WHERE  st.stop_id = \"%@\"  AND  c.%@ = '1'  AND  r.is_deleted = 0  AND   t.is_deleted = 0 AND st.arrival_time > \"%@\" ORDER BY st.arrival_time desc) GROUP BY route_id, stop_sequence ", valStr, day, [formatter stringFromDate:[NSDate date]]];
        @autoreleasepool {
            ConnectionManager *conman = [ConnectionManager new];
            [conman post_request:querySQL :valStr :@"QR_SCANNED"];
        }
        
        const char *query_stmt = [querySQL UTF8String];
        NSLog(@"%s",query_stmt);
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            NSLog(@"Error Message: %s", sqlite3_errmsg(database));
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //                NSLog(@"Result: %s, %s, %s, %s",(char *)sqlite3_column_text(statement, 0),(char *)sqlite3_column_text(statement, 1),(char *)sqlite3_column_text(statement, 2),(char *)sqlite3_column_text(statement, 3));
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)]];
                
                rows++;
            }
            sqlite3_finalize(statement);
        } else {
            NSLog(@"Something happened! %s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            sqlite3_close(database);
        }
        if (rows >= 3) {
            return resultArray;
        }
        return resultArray;
    }
    return nil;
}

- (NSMutableArray*)getIncomingBusesForStop:(NSString*)stopId AtTime:(NSString *)time AndDay:(NSString *)day
{
    const char *dbpath = [databasePath UTF8String];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    int rows = 0;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        NSString *valStr = stopId;
        
        NSString *querySQL;
        
        //        NSDate *now = [[NSDate alloc] init];
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        [dateFormatter setDateFormat:@"cccc"];
        //        NSString *day = [[dateFormatter stringFromDate:now] lowercaseString];
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        [formatter setDateFormat:@"HH:mm:ss"];
        
        querySQL = [NSString stringWithFormat:@"SELECT * FROM (SELECT   s.stop_name stop_name,  st.stop_sequence stop_sequence,  st.stop_id stop_id,  st.arrival_time arrival_time,  st.departure_time departure_time,  st.trip_id trip_id,  r.route_id route_id,  r.route_color route_color,  r.route_text_color route_text_color, c.service_id service_id FROM  stop_times st   LEFT OUTER JOIN  stops s ON st.stop_id = s.stop_id  LEFT OUTER JOIN   trips t ON st.trip_id = t.trip_id  LEFT OUTER JOIN   routes r ON t.route_id = r.route_id  LEFT OUTER JOIN   calendar c ON t.service_id = c.service_id WHERE  st.stop_id = \"%@\"  AND  c.%@ = '1'  AND  r.is_deleted = 0  AND   t.is_deleted = 0 AND st.arrival_time > \"%@\" ORDER BY st.arrival_time desc) GROUP BY route_id, stop_sequence ", valStr, day, time];
        @autoreleasepool {
            ConnectionManager *conman = [ConnectionManager new];
            [conman post_request:querySQL :valStr :@"QR_SCANNED"];
        }
        
        const char *query_stmt = [querySQL UTF8String];
        NSLog(@"%s",query_stmt);
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            NSLog(@"Error Message: %s", sqlite3_errmsg(database));
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //                NSLog(@"Result: %s, %s, %s, %s",(char *)sqlite3_column_text(statement, 0),(char *)sqlite3_column_text(statement, 1),(char *)sqlite3_column_text(statement, 2),(char *)sqlite3_column_text(statement, 3));
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)]];
                
                rows++;
            }
            sqlite3_finalize(statement);
        } else {
            NSLog(@"Something happened! %s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            sqlite3_close(database);
        }
    }
    
    NSMutableArray *splitArray = [[NSMutableArray alloc] init];
    
    if([resultArray count] >= 10)
    {
        for(int i = 10; i <= [resultArray count]; i+=10)
        {
            [splitArray addObject:[resultArray subarrayWithRange:NSMakeRange(i-10, 10)]];
        }
    }
    
    return splitArray;
}

- (NSMutableArray*) getTimeAndRoute2:(NSString *)QRData route_id:(NSString *)_route_id sequence_id:(NSString *)_sequence_id{
    const char *dbpath = [databasePath UTF8String];
    
    int rows = 0;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        //        NSLog(@"%@ %@",QRData, _time);
        NSString *valStr = [DatabaseManager validateValue:QRData];
        if (strcmp([valStr UTF8String], "unsafe") == 0) {
            return nil;
        }
        
        NSString *querySQL;
        
        //Working code
        NSDate *now = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"cccc"];
        NSString *day = [[dateFormatter stringFromDate:now] lowercaseString];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        
        //        querySQL = [NSString stringWithFormat:@"SELECT route, direction, location, time FROM  WHERE direction= '%@' and location = \"%@\" and day = '%@' and time >= %@ and route= \"%@\"order by time asc;",_direction,valStr,_day, _time, _route_number];
        querySQL = [NSString stringWithFormat:@"SELECT   s.stop_name stop_name,  st.stop_sequence stop_sequence,  st.stop_id stop_id,  st.arrival_time arrival_time,  st.departure_time departure_time,  st.trip_id trip_id,  r.route_id route_id,  r.route_color route_color,  r.route_text_color route_text_color, c.service_id service_id FROM  stop_times st   LEFT OUTER JOIN  stops s ON st.stop_id = s.stop_id  LEFT OUTER JOIN   trips t ON st.trip_id = t.trip_id  LEFT OUTER JOIN   routes r ON t.route_id = r.route_id  LEFT OUTER JOIN   calendar c ON t.service_id = c.service_id WHERE  st.stop_id = \"%@\"  AND  c.%@ = '1'  AND  r.is_deleted = 0  AND   t.is_deleted = 0 AND st.arrival_time > \"%@\" AND r.route_id = \"%@\" AND st.stop_sequence= \"%@\" ORDER BY st.arrival_time ", valStr, day, [formatter stringFromDate:[NSDate date]], _route_id, _sequence_id];
        
        const char *query_stmt = [querySQL UTF8String];
        NSLog(@"%s",query_stmt);
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            NSLog(@"Error Message: %s", sqlite3_errmsg(database));
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //                NSLog(@"Result: %s, %s, %s, %s",(char *)sqlite3_column_text(statement, 0),(char *)sqlite3_column_text(statement, 1),(char *)sqlite3_column_text(statement, 2),(char *)sqlite3_column_text(statement, 3));
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)]];
                
                rows++;
            }
        } else {
            NSLog(@"Something happened! %s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
        }
        sqlite3_close(database);
        if (rows >= 3) {
            return resultArray;
        }
        return resultArray;
    }
    return nil;
}

- (NSArray*)getNearbyRoutes
{
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *databasePath;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @".db"]];
    const char *dbpath = [databasePath UTF8String];
    
    ConnectionManager *conman = [ConnectionManager new];
    
    [conman update_gps];
    
    //    double myLat = [[conman get_latitude] doubleValue];
    //    double myLon = [[conman get_longitude] doubleValue];
    
    double myLat = 42.782772;
    double myLon = -87.808052;
    
    static double LATITUED_PER_5_MILES =  1.007236;
    static double LONGITUDE_PER_5_MILES = 1.0092595;
    
    //Working code
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"cccc"];
    NSString *weekday = [[dateFormatter stringFromDate:now] lowercaseString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *currentTimeString = [formatter stringFromDate:[NSDate date]];
    currentTimeString = @"12:00:00";
    
    //    double myLat = 42.782772;
    //    double myLon = -87.808052;
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM(SELECT s.stop_name stop_name, s.stop_lat stop_lat, s.stop_lon stop_lon, st.stop_sequence stop_sequence, st.stop_id stop_id, st.arrival_time arrival_time, st.departure_time departure_time,st.trip_id trip_id, r.route_id route_id, r.route_color route_color, r.route_text_color route_text_color, c.service_id service_id FROM  stop_times st LEFT OUTER JOIN stops s ON st.stop_id = s.stop_id LEFT OUTER JOIN trips t ON st.trip_id = t.trip_id LEFT OUTER JOIN routes r ON t.route_id = r.route_id LEFT OUTER JOIN calendar c ON t.service_id = c.service_id WHERE (stop_lat BETWEEN %f AND %f) AND (stop_lon BETWEEN %f AND %f ) AND  r.is_deleted = 0 AND  t.is_deleted = 0 AND c.\"%@\" = '1' AND  st.arrival_time > \"%@\" ORDER BY arrival_time DESC)GROUP BY stop_name ORDER BY arrival_time ASC", (myLat - LATITUED_PER_5_MILES),
                              (myLat + LATITUED_PER_5_MILES), (myLon + LONGITUDE_PER_5_MILES), (myLon - LONGITUDE_PER_5_MILES), weekday, currentTimeString];
        
        //        NSString *querySQL = @"SELECT s.stop_name stop_name FROM stop_times st";
        
        int rows = 0;
        
        const char *query_stmt = [querySQL UTF8String];
        NSLog(@"%s",query_stmt);
        NSLog(@"%d", sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL));
        NSLog(@"Error Message: %s", sqlite3_errmsg(database));
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            NSLog(@"Error Message: %s", sqlite3_errmsg(database));
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //                NSLog(@"Result: %s, %s, %s, %s",(char *)sqlite3_column_text(statement, 0),(char *)sqlite3_column_text(statement, 1),(char *)sqlite3_column_text(statement, 2),(char *)sqlite3_column_text(statement, 3));
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)]];
                [resultArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)]];
                
                rows++;
                NSLog(@"%@", resultArray);
            }
            sqlite3_close(database);
        }
    }
    
    NSMutableArray *splitArray = [[NSMutableArray alloc] init];
    
    conman = [ConnectionManager new];
    
    [conman update_gps];
    
    CLLocation *currentLoc= [[CLLocation alloc] initWithLatitude:myLat longitude:myLon];
    
    if([resultArray count] >= 10)
    {
        for(int i = 10; i <= [resultArray count]; i+=10)
        {
            NSMutableArray *route = [[NSMutableArray alloc] initWithArray:[resultArray subarrayWithRange:NSMakeRange(i-10, 10)]];
            CLLocation *stopLoc = [[CLLocation alloc] initWithLatitude:[route[1] doubleValue] longitude:[route[2] doubleValue]];
            CLLocationDistance meters = [currentLoc distanceFromLocation:stopLoc];
            int milesAway = (int)((meters/1000) * .62137f);
            
            [route addObject:[NSNumber numberWithInt:milesAway]];
            
            [splitArray addObject: route];
        }
    }
    
    NSArray *sortedArray = [splitArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if([obj1[10] intValue] < [obj2[10] intValue])
        {
            NSLog(@"Ascending");
            return NSOrderedAscending;
        } else if([obj1[10] intValue] > [obj2[10] intValue])
        {
            //            NSLog(@"Descending");
            return NSOrderedDescending;
        } else
        {
            //            NSLog(@"Same");
            return NSOrderedSame;
        }
    }];
    
    return sortedArray;
}

@end
