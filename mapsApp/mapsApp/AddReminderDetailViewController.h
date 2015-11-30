//
//  AddReminderDetailViewController.h
//  mapsApp
//
//  Created by Matthew Weintrub on 11/30/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface AddReminderDetailViewController : UIViewController

@property (strong, nonatomic) NSString* annotationTitle;
@property (strong, nonatomic) NSString* annotationSubtitle;
@property CLLocationCoordinate2D coordinate;


@end

