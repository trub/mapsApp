//
//  Stack.h
//  mapsApp
//
//  Created by Matthew Weintrub on 11/25/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

@property NSMutableArray* stack;

- (instancetype)initStack: (NSMutableArray *)stack;
- (void)addObject: (NSString *)string;
- (void)removeObject: (NSString *)string;

@end
