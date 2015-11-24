//
//  ViewController.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/23/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//@property (strong, nonatomic) CLLocationManager *locationManager;

@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init maps at code fellows
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6235733, -122.3382575);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);

    [self.mapView setRegion:region animated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setMap:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        _mapView.mapType = MKMapTypeStandard;
        
    } else
        if (sender.selectedSegmentIndex == 1)  {
            _mapView.mapType = MKMapTypeSatellite;

    }
    else
        if (sender.selectedSegmentIndex == 2)  {
            _mapView.mapType = MKMapTypeHybrid;
        }
}
- (IBAction)locationButtonPressed:(UIButton *)sender {
    
    NSString *locationTitle = sender.titleLabel.text;
    
    if([locationTitle isEqualToString:@"1"]) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake( 47.706267, -122.325811); // south lake union
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
        
        [self.mapView setRegion:region animated:YES];
        
    }
    
    if([locationTitle isEqualToString:@"2"]) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6200893, -122.3297394); // capitol hill
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
        
        [self.mapView setRegion:region animated:YES];
    }
    
    if([locationTitle isEqualToString:@"3"]) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6100893,-122.3297394); // IKEA store haha.
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
        
        [self.mapView setRegion:region animated:YES];
    }
    
    
 
}
@end
