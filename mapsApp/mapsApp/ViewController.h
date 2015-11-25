//
//  ViewController.h
//  mapsApp
//
//  Created by Matthew Weintrub on 11/23/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MapKit;
@import CoreLocation;

@interface ViewController : UIViewController {
    MKMapView *mapView;
}

#pragma mark - Properties

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)setMap:(UISegmentedControl *)sender;


@end

