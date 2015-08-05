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


#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseManager : NSObject
{
    NSString *databasePath;
    NSInteger *versionPath;
}

+(DatabaseManager*)getSharedInstance;
+(NSString *)validateValue:(NSString *)query;
- (NSArray*)getNearbyRoutes;
-(sqlite3 *)get_database;
-(BOOL)createDB;
-(BOOL) create__version_db;
-(BOOL)initialize;
-(void) drop__db;
-(BOOL) create__db;
-(NSMutableArray *)getTimeAndRoute:(NSString *)QRData time:(NSString *)_time day:(NSString *)_day;
- (NSMutableArray*) getTimeAndRoute2:(NSString *)QRData route_id:(NSString *)_route_id sequence_id:(NSString *)_sequence_id;
- (NSMutableArray*)getIncomingBusesForStop:(NSString*)stopId AtTime:(NSString *)time AndDay:(NSString *)day;
@end
