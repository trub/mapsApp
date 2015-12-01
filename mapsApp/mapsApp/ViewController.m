//
//  ViewController.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/23/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <LocationAPIDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
- (IBAction)longPressGestureRecognized:(id)sender;

@end

@implementation ViewController

@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestPermissions];
    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [[LocationAPI sharedAPI] setDelegate:self];
    [[LocationAPI sharedAPI] beginLocationUpdate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[LocationAPI sharedAPI] endLocationUpdate];

}


- (void)setRegion: (MKCoordinateRegion)region {
    [self.mapView setRegion:region animated:YES];
}

- (void)requestPermissions {
    // NSLocationWhenInUseUsageDescription key is required in info.plist. Add valid reason for location use.
    [self setLocationManager:[[CLLocationManager alloc]init]];
    [self.locationManager requestWhenInUseAuthorization];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddReminderDetailViewController"]) {
        if ([segue.destinationViewController isKindOfClass:[AddReminderDetailViewController class]]) {
            AddReminderDetailViewController *detailVC = (AddReminderDetailViewController *)segue.destinationViewController;
            MKAnnotationView *annotation = (MKAnnotationView *)sender;
            detailVC.annotationTitle = annotation.annotation.title;
            detailVC.annotationSubtitle = annotation.annotation.subtitle;
        }
    }
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomLocationPin"];
    annotationView.annotation = annotation;
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomLocationPin"];
    }
    annotationView.canShowCallout = YES;
    UIButton *rightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCallout;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"LocationDetailViewController" sender:view];
}

#pragma mark - LocationServiceDelegate


- (void)locationAPIUpateLocation:(CLLocation *)location {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0);
    [self setRegion:region];
}

#pragma mark - IBActions


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
- (IBAction)longPressGestureRecognized:(UIGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.coordinate = coordinate;
        annotation.title = @"New Location";
        annotation.subtitle = @"What are we doing here?";
        [self.mapView addAnnotation:annotation];
    }
}

@end
