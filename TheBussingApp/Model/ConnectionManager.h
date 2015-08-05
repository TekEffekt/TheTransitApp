//  ConnectionManager.h
//  KenoshaAreaTransit
//
//  ConnectionManager builds and queries a local sqlite3 database.  The database
//  will house the route information, including a unique identifier (_id), a time,
//  a direction, a stop name, a route number and whether or not the time is on a
//  weekday or weekend.
//
//  Created by Matthew Zygowicz
//


#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface ConnectionManager : NSObject
{
    NSString *versionURL;
    NSString *dataURL;
    NSString *debugURL;
    NSString *event;
    NSString *latitude;
    NSString *longitude;
    
}
//@property (nonatomic, retain) CLLocationManager *locationManager;

-(void) post_request:(NSString*)query: (NSString*)location: (NSString*)event;
-(void)update_gps;
-(NSString *) get_longitude;
-(NSString *) get_latitude;
-(NSString *)get_device_id;
@end
