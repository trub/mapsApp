//
//  Reminder.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/30/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic name;
@dynamic location;
@dynamic radius;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Reminder";
}

@end
