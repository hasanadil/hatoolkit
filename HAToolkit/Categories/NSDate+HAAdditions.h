//
//  UIColor+HAAdditions.h
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (HAAdditions)

-(BOOL) isYesterday;

-(BOOL) isSameDayAsDate:(NSDate*)otherDate;

-(NSInteger) numberOfDaysFromDate:(NSDate*)otherDate;

-(NSDate*) earliestDateTimeOnThisDate;

-(NSDate*) latestDateTimeOnThisDate;

-(NSString*) description;

-(NSString*) shortDescription;

-(NSString*) hourDescription;

-(NSArray*) hourlyDateTimesDuringTheDay;

@end
