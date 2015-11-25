//
//  Stack.m
//  mapsApp
//
//  Created by Matthew Weintrub on 11/25/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (instancetype)initStack:(NSMutableArray *)stack {
    if(self = [super init]) {
        if (self) {
            self.stack = [[NSMutableArray alloc]init];
        }
    }
    return self;

}

- (void)addObject:(NSString *)string {
    [self.stack insertObject:string atIndex:0];
}

- (void)removeObject:(NSString *)string {
    [self.stack removeObjectAtIndex:0];
    
}

@end

