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

+ (long long)millisecondsSince1970
{
    NSTimeInterval seconds = [[NSDate date]timeIntervalSince1970];
    long long milliseconds = llround(seconds * 1000);
    return milliseconds;
}

+ (long long)millisecondsSince1970TwoYearsFromNow
{
    static int64_t twoYears = 63072000000;
    NSDate *now = [NSDate date];
    int64_t result = [now timeIntervalSince1970] * 1000 + twoYears;
    return result;
}
+(NSDate *)dateFromMillisSince1970:(long long)interval
{
    if (interval <= -7000000000000) {
        return nil;
    }
    NSTimeInterval timeInterval = ((double)interval) / 1000.0;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}
+(long long)millisDateOnlyFromMillisSince1970:(long long)interval
{
    int64_t dateRounded = (int64_t)floor(((double)interval) / 86400000.0);
    int64_t millisRounded = dateRounded * 86400000;
    return millisRounded;
}

+ (NSString*)birthdateDisplayStr: (long long)dateLong
{
    if (![self isValidBirthdate:dateLong]) return nil;
    NSString* timeMMMd = NSLocalizedString(@"time_format_MMMdd", @"MMM d(M月d日)");
    
    NSDate* date = [self dateFromMillisSince1970 : dateLong];
    return [date stringForFormat:timeMMMd];
}

+ (BOOL)isValidBirthdate:(long long)dateLong
{
    NSDate* jan1st1900 = [NSDate dateWithYear:1900 month:1 day:1];
    NSDate* today = [NSDate date];
    long long minDob = [[NSNumber numberWithLongLong:[jan1st1900 timeIntervalSince1970]*1000] longLongValue];
    long long maxDob = [[NSNumber numberWithLongLong:[today timeIntervalSince1970]*1000] longLongValue];
    return (minDob <= dateLong && maxDob > dateLong);
}

+ (NSDate *)dateOfCurBuild
{
    return [self dateWithFormat:@"MMM dd yyyy HH:mm:ss"
                  andDateString:[NSString stringWithFormat:@"%s %s",__DATE__, __TIME__]];
}

- (NSString *)stringForFormat:(NSString *)format
{
    if (0 == format.length)
    {
        return nil;
    }
    
    NSDateFormatter *formatter = [NSDate appDateFormatter];
    [formatter setDateFormat:format];
    
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

- (long long)millisecondsSince1970
{
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    NSNumber* num = [NSNumber numberWithDouble:timeInterval * 1000];
    long long timeMillis = [num longLongValue];
    return timeMillis;
}

- (NSString*)dateStringMMMDYYYY
{
    NSString* timeYYYYMMdd = NSLocalizedString(@"time_format_YYYYMMdd", @"MMM d, yyyy (yyyy年MM月dd日)");
    return [self stringForFormat:timeYYYYMMdd];
}

- (NSString*)dateStringMMMDYYYYHideThisYear
{
    NSString* timeYYYYMMdd = NSLocalizedString(@"time_format_YYYYMMdd", @"MMM d, yyyy (yyyy年MM月dd日)");
    NSString* timeMMdd = NSLocalizedString(@"time_format_MMdd", @"MMM d (MM月dd日)");
    
    NSDate *baseDate = [NSDate date];
    
    NSDateComponents *current = [[NSCalendar currentCalendar] components:
                                 NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                fromDate:baseDate];
    NSDateComponents *start = [[NSCalendar currentCalendar] components:
                               NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                              fromDate:self];
    
    NSString *formatStart = nil;
    
    if (current.year != start.year)
    {
        formatStart = timeYYYYMMdd;
        
    }
    else
    {
        formatStart = timeMMdd;
    }
    return [self stringForFormat:formatStart];
}

- (NSString*)dateStringMMMDYYYYHHMMHideThisYear
{
    NSString* timeYYYYMMddHHmm = NSLocalizedString(@"time_format_YYYYMMddHHmm", @"MMM d, yyyy HH:mm(yyyy年MM月dd日 HH:mm)");
    NSString* timeMMddHHmm = NSLocalizedString(@"time_format_MMddHHmm3", @"MMM d HH:mm(MM月dd日 HH:mm)");
    
    NSDate *baseDate = [NSDate date];
    
    NSDateComponents *current = [[NSCalendar currentCalendar] components:
                                 NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                fromDate:baseDate];
    NSDateComponents *start = [[NSCalendar currentCalendar] components:
                               NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                              fromDate:self];
    
    NSString *formatStart = nil;
    
    if (current.year != start.year)
    {
        formatStart = timeYYYYMMddHHmm;
    }
    else
    {
        formatStart = timeMMddHHmm;
    }
    return [self stringForFormat:formatStart];
}

- (NSString*)dateStringHHMMSS
{
    NSString* HHmmss = NSLocalizedString(@"time_format_time_format_HHmmss", @"HHmmss");
    return [self stringForFormat:HHmmss];
}

- (NSString*)dateStringVariableFormat
{
    NSString* timeYYYYMMddHHmm = NSLocalizedString(@"time_format_YYYYMMddHHmm", @"MMM d, yyyy HH:mm(yyyy年MM月dd日 HH:mm)");
    NSString* timeMMddHHmm = NSLocalizedString(@"time_format_MMddHHmm", @"MMM d HH:mm(MM月dd日 HH:mm)");
    NSString* timeHHmm =NSLocalizedString(@"time_format_HHmm", @"HH:mm");
    
    NSDate* baseDate = [NSDate date];
    
    NSDateComponents *current = [[NSCalendar currentCalendar] components:
                                 NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                fromDate:baseDate];
    NSDateComponents *start = [[NSCalendar currentCalendar] components:
                               NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                              fromDate:self];
    
    NSString* formatStart = nil;
    
    if (current.year != start.year)
    {
        formatStart = timeYYYYMMddHHmm;
    }
    else if (current.year == start.year &&
             current.month == start.month &&
             current.day == start.day)
    {
        NSString* formatTodayTime = NSLocalizedString(@"general_format_today_at", @"%@ (今天 %@)");
        formatStart = [NSString stringWithFormat:formatTodayTime,timeHHmm];
    }
    else
    {
        formatStart = timeMMddHHmm;
    }
    return [self stringForFormat:formatStart];
}

- (BOOL)isLaterThan:(NSDate *)date
{
    BOOL isLaterThan = ([self timeIntervalSinceDate:date] > 0);
    return isLaterThan;
}



@end
