//
//  CLHeading+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "CLHeading+HAAdditions.h"

@implementation CLHeading (HAAdditions)

+ (NSString*) cardinalForHeading:(CLLocationDirection)theHeading {
    NSString *modifier = nil;
    if ( theHeading >= 0 && theHeading <= 22 )
        modifier = NSLocalizedString(@"North", @"North");
    else if ( theHeading > 22 && theHeading < 68 )
        modifier = NSLocalizedString(@"Northeast", @"Northeast");
    else if ( theHeading >= 68 && theHeading <= 112 )
        modifier = NSLocalizedString(@"East", @"East");
    else if ( theHeading > 112 && theHeading < 158 )
        modifier = NSLocalizedString(@"Southeast", @"Southeast");
    else if ( theHeading >= 158 && theHeading <= 202 )
        modifier = NSLocalizedString(@"South", @"South");
    else if ( theHeading > 202 && theHeading < 248 )
        modifier = NSLocalizedString(@"Southwest", @"Southwest");
    else if ( theHeading >= 248 && theHeading <= 292 )
        modifier = NSLocalizedString(@"West", @"West");
    else if ( theHeading > 292 && theHeading < 238 )
        modifier = NSLocalizedString(@"Northwest", @"Northwest");
    else
        modifier = NSLocalizedString(@"North", @"North");
    
    return modifier;
}

+ (NSString*) cardinalAbbreviationForHeading:(CLLocationDirection)theHeading {
    NSString *modifier = nil;
    if ( theHeading >= 0 && theHeading <= 22 )
        modifier = NSLocalizedString(@"N", @"North");
    else if ( theHeading > 22 && theHeading < 68 )
        modifier = NSLocalizedString(@"NE", @"Northeast");
    else if ( theHeading >= 68 && theHeading <= 112 )
        modifier = NSLocalizedString(@"E", @"East");
    else if ( theHeading > 112 && theHeading < 158 )
        modifier = NSLocalizedString(@"SE", @"Southeast");
    else if ( theHeading >= 158 && theHeading <= 202 )
        modifier = NSLocalizedString(@"S", @"South");
    else if ( theHeading > 202 && theHeading < 248 )
        modifier = NSLocalizedString(@"SW", @"Southwest");
    else if ( theHeading >= 248 && theHeading <= 292 )
        modifier = NSLocalizedString(@"W", @"West");
    else if ( theHeading > 292 && theHeading < 238 )
        modifier = NSLocalizedString(@"NW", @"Northwest");
    else
        modifier = NSLocalizedString(@"N", @"North");
    
    return modifier;
}

+ (NSString*) formattedStringForHeading:(CLLocationDirection)theHeading format:(NSString*)format abbreviate:(BOOL)abbreviate {
    NSString *modifier = ( abbreviate ? [CLHeading cardinalAbbreviationForHeading:theHeading]
                          : [CLHeading cardinalForHeading:theHeading] );
    
    if ( format ) {
        NSString *numeric = [NSString stringWithFormat:format, theHeading];
        NSString *heading = [NSString stringWithFormat:@"%@º %@", numeric, modifier];
        return heading;
    } else {
        NSString *heading = [NSString stringWithFormat:@"%.0fº %@", theHeading, modifier];
        return heading;
    }
}

- (NSString*) formattedHeading:(BOOL)trueHeading {
    CLLocationDirection theHeading = ((trueHeading && self.trueHeading > 0) ?
                                      self.trueHeading : self.magneticHeading);
    
    return [CLHeading formattedStringForHeading:theHeading format:nil abbreviate:YES];
}

@end
