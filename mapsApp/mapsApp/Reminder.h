//
//  Reminder.h
//  mapsApp
//
//  Created by Matthew Weintrub on 11/30/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Reminder : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSNumber *radius;

@end


