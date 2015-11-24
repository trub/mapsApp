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

@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
@end
