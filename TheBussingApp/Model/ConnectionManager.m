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

#import "ConnectionManager.h"
//#import "SSKeychain/SSKeychain.h"
#import "SSKeychain.h"

@implementation ConnectionManager

-(id) init
{
    self = [super init];
    if(self)
    {
        //do something
        versionURL = @"http://70.63.28.41/resources/data/route_version.xml";
        dataURL = @"http://70.63.28.41/resources/data/routetable.xml";
        debugURL = @"http://70.63.28.41/index.php//datamine";
    }
    return self;
}

-(void) post_request:(NSString*)query: (NSString*)location: (NSString*)event{
    NSString *device_id = [self get_unique_id];
    [self update_gps];
    //
    //    if ([event  isEqual: @"DEBUG"]){
    NSString *strupload=[NSString stringWithFormat:@"query=%@&location=%@&event=%@&device_id=%@&longitude=%@&latitude=%@",query,location,event, device_id,longitude, latitude];
    NSString *strurl=debugURL;
    NSString *strpostlength=[NSString stringWithFormat:@"%d",[strupload length]];
    NSMutableURLRequest *urlrequest=[[NSMutableURLRequest alloc]init];
    
    [urlrequest setURL:[NSURL URLWithString:strurl]];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setValue:strpostlength forHTTPHeaderField:@"Content-Length"];
    [urlrequest setHTTPBody:[strupload dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlrequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         //Post request ends here
         //Do nothing for this just hides in the background
         //         NSError *error1;
         //         NSDictionary *res=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
     }];
    //    }
}

-(void)update_gps{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //    [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    NSNumber *lat = [NSNumber numberWithDouble:locationManager.location.coordinate.latitude];
    NSNumber *lon = [NSNumber numberWithDouble:locationManager.location.coordinate.longitude];
    
    [locationManager stopUpdatingLocation];
    latitude =[lat stringValue];
    longitude = [lon stringValue];
}
-(NSString*)get_latitude
{
    return latitude;
}
-(NSString*)get_longitude
{
    return longitude;
}
-(NSString*)get_unique_id
{
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    
    return strApplicationUUID;
    
}

@end
