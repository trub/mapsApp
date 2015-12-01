//
//  AddReminderDetailViewController.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/30/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "AddReminderDetailViewController.h"
#import <Parse/Parse.h>
#import "Reminder.h"

#import "LocationAPI.h"

@import MapKit;

@interface AddReminderDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;
- (IBAction)createReminderButtonSelected:(UIButton *)sender;

@end

@implementation AddReminderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", self.annotationTitle);
    NSLog(@"%f %f", self.coordinate.latitude, self.coordinate.longitude);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.nameTextField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)createReminderButtonSelected:(UIButton *)sender {
    
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = self.nameTextField.text;
    reminder.radius = [NSNumber numberWithFloat:self.radiusTextField.text.floatValue];
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        NSLog(@"Reminder saved to Parse.");
        
        // If completion was set.
        
        if (self.completion) {
            
            // Check for abilities then...
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                
                // Create new region and...
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:self.radiusTextField.text.floatValue identifier:self.nameTextField.text];
                [[[LocationAPI sharedAPI]locationManager]startMonitoringForRegion:region];
                
                
                // Pass it back to be added to the map.
                self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:self.radiusTextField.text.floatValue]);
                
                // Dismiss.
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
    }];
}
@end
