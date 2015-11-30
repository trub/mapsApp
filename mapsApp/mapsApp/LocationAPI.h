//
//  LocationAPI.h
//  mapsApp
//
//  Created by Matthew Weintrub on 11/25/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

@import UIKit;
@import CoreLocation;

@protocol LocationAPIDelegate <NSObject>

- (void)locationAPIUpateLocation: (CLLocation*)location;

@end

@interface LocationAPI : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) id delegate;

+(LocationAPI *)sharedAPI;

@end
