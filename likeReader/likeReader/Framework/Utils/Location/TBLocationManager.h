//
//  TBLocationManager.h
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBLocationManager : NSObject

@property (nonatomic, readonly) NSString *currentLocationName;
@property (nonatomic, readonly) CLLocationCoordinate2D currentLocation;
@property (nonatomic, readonly) CLLocationDegrees currentLocationAltitude;
@property (nonatomic, readonly) BOOL isLocationAuthorized;

@end
