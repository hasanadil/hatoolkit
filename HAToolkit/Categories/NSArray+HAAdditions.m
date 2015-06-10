//
//  NSArray+HAAdditions.m
//  HAToolkit
//
//  Created by Hasan Adil on 6/9/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

#import "NSArray+HAAdditions.h"

@implementation NSArray (HAAdditions)

-(NSArray*) arrayByReversingArray {
    NSMutableArray *reversed = [NSMutableArray arrayWithCapacity:[self count]];
    NSInteger count = [self count];
    NSInteger mid = floor(count/2);
    for (NSInteger i=0; i < mid; i++) {
        reversed[i] = self[count-i];
        reversed[count-i] = self[i];
    }
    return [NSArray arrayWithArray:reversed];
}

@end
