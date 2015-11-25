//
//  ViewController.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/23/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation ViewController


@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // As of iOS 8, you need to ask for permissions first.
    [self requestPermissions];
    
    //init maps at code fellows
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6235733, -122.3382575);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);


    [self.mapView setRegion:region animated:YES];


}
//
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [errorAlert show];
//    NSLog(@"Error: %@",error.description);
//}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
}

- (void)requestPermissions {
    
    // NSLocationWhenInUseUsageDescription key is required in info.plist. Add valid reason for location use.
    // Make sure to enable location updates in Simulator.
    
    [self setLocationManager:[[CLLocationManager alloc]init]];
    [self.locationManager requestWhenInUseAuthorization];
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
