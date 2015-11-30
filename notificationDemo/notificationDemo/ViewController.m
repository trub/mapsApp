//
//  ViewController.m
//  notificationDemo
//
//  Created by Matthew Weintrub on 11/25/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didShowUp:) name:@"ViewDidAppear" object:nil ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didShowUp: (NSNotification *)notify {
    NSLog(@"test:");
    if ([[notify object]isKindOfClass:[NSDictionary class]]) {
        NSDictionary *object = (NSDictionary *)notify.object;
        
        NSLog(@"notification reciedved %@", object[@"dope"]);
    };
    
}

@end
