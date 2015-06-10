//
//  UIColor+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "NSDate+HAAdditions.h"

@implementation NSDate (HAAdditions)

-(NSString*) description
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterFullStyle];
    [df setTimeStyle:NSDateFormatterFullStyle];
    return [df stringFromDate:self];
}

-(NSString*) hourDescription
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"ha"];
    return [df stringFromDate:self];
}

-(NSString*) shortDescription
{
    if ([self isSameDayAsDate:[NSDate date]]) {
        return NSLocalizedString(@"Today", nil);
    }
    else {
        if ([self isYesterday]) {
            return NSLocalizedString(@"Yesterday", nil);
        }
        else {
            NSDateFormatter* df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"EEEE, MMM dd"];
            return [df stringFromDate:self];
        }
    }
}

-(BOOL) isYesterday
{
    return [[NSCalendar currentCalendar] isDateInYesterday:self];
}

-(BOOL) isSameDayAsDate:(NSDate*)otherDate {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:otherDate];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

-(NSInteger) numberOfDaysFromDate:(NSDate*)otherDate
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:self];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:otherDate];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

-(NSDate*) earliestDateTimeOnThisDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    [comps setValue:0 forComponent:NSCalendarUnitHour];
    [comps setValue:1 forComponent:NSCalendarUnitMinute];
    [comps setValue:1 forComponent:NSCalendarUnitSecond];
    
    return [calendar dateFromComponents:comps];
}

-(NSDate*) latestDateTimeOnThisDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    [comps setValue:23 forComponent:NSCalendarUnitHour];
    [comps setValue:59 forComponent:NSCalendarUnitMinute];
    [comps setValue:59 forComponent:NSCalendarUnitSecond];
    
    return [calendar dateFromComponents:comps];
}

-(NSArray*) hourlyDateTimesDuringTheDay
{
    NSTimeInterval secondsInHour = 3600;
    NSDate* hour = [self earliestDateTimeOnThisDate];
    
    NSMutableArray* hourlyDates = [NSMutableArray array];
    [hourlyDates addObject:hour];
    
    for (NSInteger hourIndex = 1; hourIndex <= 24; hourIndex++) {
        hour = [hour dateByAddingTimeInterval:secondsInHour];
        [hourlyDates addObject:hour];
    }
    return [NSArray arrayWithArray:hourlyDates];
}


@end
