//
//  LocationAPI.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/25/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "LocationAPI.h"
@import CoreLocation;

@interface LocationAPI () <CLLocationManagerDelegate>

@end

@implementation LocationAPI

+ (LocationAPI*)sharedAPI {
    static LocationAPI *sharedAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPI = [[self alloc]init];
    });
    
    return sharedAPI;
}

- (id)init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100; // Meters.
        [_locationManager requestWhenInUseAuthorization];
    }
    return self;
}

- (void)beginLocationUpdate {
    [[[LocationAPI sharedAPI]locationManager]startUpdatingLocation];
}

- (void)endLocationUpdate {
    [[[LocationAPI sharedAPI]locationManager]stopUpdatingLocation];

}



#pragma mark - Location Manager

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.delegate locationAPIUpateLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
}


@end

