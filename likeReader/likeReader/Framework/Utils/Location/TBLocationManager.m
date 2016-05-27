//
//  TBLocationManager.m
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//
#import "INTULocationManager.h"
#import "TBLocationManager.h"

@interface TBLocationManager () <CLLocationManagerDelegate>
{
    CLGeocoder *_geocoder;
}
@property (assign, nonatomic) NSInteger locationRequestID;

@end

static TBLocationManager* g_locationManager = nil;

@implementation TBLocationManager

+ (instancetype)sharedInstance
{
    @synchronized(self)
    {
        if (!g_locationManager)
        {
            g_locationManager = [[TBLocationManager alloc] init];
        }
    }
    return g_locationManager;
}

- (void)dealloc
{
    _geocoder = nil;
}

- (BOOL)isLoationReady
{
    if (!self.currentLocationAltitude ||
        !self.currentLocation.latitude ||
        !self.currentLocation.longitude)
    {
        return NO;
    }
    return YES;
}

- (void)clearLocationAndRefresh:(void(^)(BOOL isPermit, CLLocationCoordinate2D location, CLLocationDegrees altitude, NSString *placeName))onComplete
{
    _currentLocationName = nil;
    _currentLocation.latitude = 0.0;
    _currentLocation.longitude = 0.0;
    _currentLocationAltitude = 0.0;
    [self refreshLocation:onComplete];
}

- (void)refreshLocation:(void(^)(BOOL isPermit, CLLocationCoordinate2D location, CLLocationDegrees altitude, NSString *placeName))onComplete
{
    void (^onCompleteCopy)(BOOL isPermit, CLLocationCoordinate2D location, CLLocationDegrees altitude, NSString *placeName) = [onComplete copy];
    
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    self.locationRequestID = [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock
                                                                timeout:(_isLocationAuthorized?10.0:1.0)
                                                   delayUntilAuthorized:YES
                                                                  block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status)
                              {
                                  if (status == INTULocationStatusSuccess ||
                                      status == INTULocationStatusTimedOut)
                                  {
                                      _isLocationAuthorized = YES;
                                      _currentLocation = currentLocation.coordinate;
                                      _currentLocationAltitude = currentLocation.altitude;
                                      [self refreshLocationName:currentLocation onComplete:onCompleteCopy];
                                  }
                                  else {
                                      if (status == INTULocationStatusServicesNotDetermined) {
                                      } else if (status == INTULocationStatusServicesDenied) {
                                      } else if (status == INTULocationStatusServicesRestricted) {
                                      } else if (status == INTULocationStatusServicesDisabled) {
                                      } else {
                                      }
                                      _isLocationAuthorized = NO;
                                      if (onCompleteCopy) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              onCompleteCopy(NO, _currentLocation, _currentLocationAltitude, _currentLocationName);
                                          });
                                      }
                                  }
                                  self.locationRequestID = NSNotFound;
                              }];
}

- (void)refreshLocationName:(CLLocation *)location onComplete:(void(^)(BOOL isPermit, CLLocationCoordinate2D location, CLLocationDegrees altitude, NSString *placeName))onComplete{
    void (^onCompleteCopy)(BOOL isPermit, CLLocationCoordinate2D location, CLLocationDegrees altitude, NSString *placeName) = [onComplete copy];
    
    if (!location) {
        if (onCompleteCopy) {
            dispatch_async(dispatch_get_main_queue(), ^{
                onCompleteCopy(YES, location.coordinate, location.altitude, _currentLocationName);
            });
        }
        return;
    }
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
        
        [_geocoder
         reverseGeocodeLocation:location
         completionHandler:^(NSArray *placemarks, NSError *error) {
             if (error == nil &&
                 [placemarks count] > 0){
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 _currentLocationName = [NSString stringWithFormat:@"%@ %@", placemark.name, placemark.country];
             }
             
             _geocoder = nil;
             if (onCompleteCopy) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     onCompleteCopy(YES, location.coordinate, location.altitude, _currentLocationName);
                 });
             }
         }];
    }
}

@end
