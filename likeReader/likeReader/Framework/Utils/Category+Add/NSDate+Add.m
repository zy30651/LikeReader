//
//  NSDate+Add.m
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "NSDate+Add.h"


static NSDateFormatter* g_appDateFormatter = nil;
static NSCalendar* g_currentCanlendar = nil;

@implementation NSDate (Add)

+ (NSDateFormatter *)appDateFormatter
{
    if (!g_appDateFormatter) {
        g_appDateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [g_appDateFormatter setLocale:usLocale];
    }
    return g_appDateFormatter;
}


+ (NSCalendar*) currentCalendar
{
    if (!g_currentCanlendar)
    {
        g_currentCanlendar = [NSCalendar currentCalendar];
    }
    return g_currentCanlendar;
}


+ (NSArray*)arrayYearStringsFrom1970
{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger currentYear = [components year];
    NSInteger numOfYears = currentYear - 1970 + 1;
    NSMutableArray* arrYearStrs = [[NSMutableArray alloc] initWithCapacity:numOfYears];
    NSString* yearStr = nil;
    for (NSInteger year = currentYear; year >= 1970; year--)
    {
        yearStr = [NSString stringWithFormat:@"%ld", (long)year];
        [arrYearStrs addObject:yearStr];
    }
    return arrYearStrs;
}

+ (NSDate *)dateWithFormat:(NSString *)format andDateString:(NSString *)strDate{
    if (0 == format.length || 0 == strDate.length)
    {
        return nil;
    }
    NSDateFormatter *formatter = [NSDate appDateFormatter];
    [formatter setDateFormat:format];
    return [formatter dateFromString:strDate];
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day{
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.year = year;
    comp.month = month;
    comp.day = day;
    
    return [[self currentCalendar] dateFromComponents:comp];
}

- (long long)millisecondsSince1970
{
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    NSNumber* num = [NSNumber numberWithDouble:timeInterval * 1000];
    long long timeMillis = [num longLongValue];
    return timeMillis;
}

@end
