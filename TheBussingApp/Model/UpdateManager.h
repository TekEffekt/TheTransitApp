//
//  UpdateManager.h
//  KenoshaAreaTransit
//
//  Created by Valerie Berglind on 5/9/14.
//  Copyright (c) 2014 Richard Arthur Lebbin III. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "XMLReader.h"

@interface UpdateManager : NSObject

-(void)updateDatabase: (sqlite3 *)db;
-(int)getRemoteVersion: (NSURL *) versionURL;
-(int)getUserVersion:(sqlite3 *) db;
/*************Commented out due to warnings******************/
//-(void)updateVersionNumber:(int) version_number: (sqlite3 *) database;
-(void)updateRoutes:(sqlite3 *) database: (NSDictionary *) routes;
-(NSString *) getUpdateDatabase: (NSURL *) updateURL;
- (NSString *) escapeString:(NSString *)string;
@end
