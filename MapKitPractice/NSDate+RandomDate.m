//
//  NSDate+RandomDate.m
//  MapKitPractice
//
//  Created by Syngmaster on 12/05/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "NSDate+RandomDate.h"

@implementation NSDate (RandomDate)

- (NSDate *)randomDateInYearOfDate {
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [comps setMonth:arc4random_uniform(12)];
    [comps setYear:(arc4random()%(2007-1980)) + 1980];
    
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[currentCalendar dateFromComponents:comps]];
    
    [comps setDay:arc4random_uniform((int)range.length)];
    
    return [currentCalendar dateFromComponents:comps];
}

@end
