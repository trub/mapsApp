//
//  AddReminderDetailViewController.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/30/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "AddReminderDetailViewController.h"
#import <Parse/Parse.h>
#import "LocationAPI.h"

@interface AddReminderDetailViewController ()

@end

@implementation AddReminderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", self.annotationTitle);
    NSLog(@"%f %f", self.coordinate.latitude, self.coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
