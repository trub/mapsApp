//
//  AddReminderDetailViewController.h
//  mapsApp
//
//  Created by Matthew Weintrub on 11/30/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

@import UIKit;
@import MapKit;

typedef void(^AddReminderDetailViewControllerCompletion)(MKCircle *circle);

@interface AddReminderDetailViewController : UIViewController

@property (copy, nonatomic) AddReminderDetailViewControllerCompletion completion;
@property (strong, nonatomic) NSString* annotationTitle;
@property (strong, nonatomic) NSString* annotationSubtitle;
@property (nonatomic)CLLocationCoordinate2D coordinate;


@end

