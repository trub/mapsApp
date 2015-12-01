//
//  AppDelegate.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/23/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupParse];
    [self registerForNotifications];
    
    return YES;
}

- (void)setupParse {
    [Parse setApplicationId:@"6R0R8AaxwKbdejbP692PWbwRZEgyhbcSsy5khGzh"
                  clientKey:@"b2X66LnCNZvmyRLzEmkmSz8NZVR23gC9f2NHJerh"];
}

- (void)registerForNotifications {
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
}


@end

