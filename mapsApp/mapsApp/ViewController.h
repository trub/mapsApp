//
//  ViewController.h
//  mapsApp
//
//  Created by Matthew Weintrub on 11/23/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MapKit;

@interface ViewController : UIViewController {
    MKMapView *mapView;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)setMap:(UISegmentedControl *)sender;


@end

