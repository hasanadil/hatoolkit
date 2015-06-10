//
//  CLHeading+HAAdditions.h
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLHeading (HAAdditions)

+ (NSString*) formattedStringForHeading:(CLLocationDirection)theHeading format:(NSString*)format abbreviate:(BOOL)abbreviate;

- (NSString*) formattedHeading:(BOOL)trueHeading;

@end
