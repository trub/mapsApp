//
//  ViewController.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/23/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

@import CoreLocation;

#import "ViewController.h"
#import "LocationAPI.h"
#import "AddReminderDetailViewController.h"
#import "Reminder.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface ViewController () <LocationAPIDelegate, MKMapViewDelegate, PFLogInViewControllerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
- (IBAction)longPressGestureRecognized:(id)sender;

@end

@implementation ViewController

@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    
    //add parse login
    [self login];
    
    [self requestPermissions];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //set location
    [[LocationAPI sharedAPI] setDelegate:self];
    [[LocationAPI sharedAPI] beginLocationUpdate];

    [self fetchRegions];

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
    if ([segue.identifier isEqualToString:@"AddReminderSegue"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            AddReminderDetailViewController *detailVC = (AddReminderDetailViewController *)segue.destinationViewController;
            MKAnnotationView *annotation = (MKAnnotationView *)sender;
            detailVC.annotationTitle = annotation.annotation.title;
            detailVC.annotationSubtitle = annotation.annotation.subtitle;
            detailVC.coordinate = annotation.annotation.coordinate;

            __weak typeof(self) weakSelf = self;

            detailVC.completion = ^(MKCircle *circle) {

                [weakSelf.mapView removeAnnotation:annotation.annotation];
                NSLog(@"%@", [[LocationAPI sharedAPI]locationManager]);

            };


        }
    }
}


#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) { return nil; }
    
    // Add view.
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
    annotationView.annotation = annotation;
    
    if(!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    }
    
    annotationView.canShowCallout = true;
    UIButton *rightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCallout;
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"AddReminderSegue" sender:view];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    circleRenderer.strokeColor = [UIColor blueColor];
    circleRenderer.fillColor = [UIColor redColor];
    circleRenderer.alpha = 0.5;
    return circleRenderer;
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
- (IBAction)longPressGestureRecognized:(UILongPressGestureRecognizer*)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.coordinate = coordinate;
        annotation.title = @"New Location";
        annotation.subtitle = @"Yolo cholo?";
        
        [self.mapView addAnnotation:annotation];
    }
}


#pragma mark - Parse

- (void)fetchRegions {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reminder"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        for (MKCircle *circle in self.mapView.overlays) {
            [self.mapView removeOverlay:circle];
        }
        
        NSMutableArray *regions = [[NSMutableArray alloc]init];
        
        for (Reminder *reminder in objects) {
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(reminder.location.latitude, reminder.location.longitude) radius:50.0 /*modify this*/];
            
            [regions addObject:circle];
        }
        
        [self.mapView addOverlays:regions];
        
    }];
    
}

- (void)login {
    if (![PFUser currentUser]) {
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc]init];
        loginViewController.delegate = self;
        
        [self presentViewController:loginViewController animated:NO completion:nil];
    }
    else {
        [self setupAdditionalUI];
    }
}

- (void)setupAdditionalUI {
    UIBarButtonItem *signoutButton = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signout)];
    self.navigationItem.leftBarButtonItem = signoutButton;
}

- (void)signout {
    [PFUser logOut];
    [self login];
}

// Delegate

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI];
}



@end
