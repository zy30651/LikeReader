//
//  NSDate+Add.h
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Add)


+ (NSDate *)dateWithFormat:(NSString *)format
             andDateString:(NSString *)strDate;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day;


/** 返回1970年到现在多有年份 */
+ (NSArray*)arrayYearStringsFrom1970;
/** 返回1970年到现在的毫秒数 */
+ (long long)millisecondsSince1970;
/** 自1970年到今后2年的秒数 */
+ (long long) millisecondsSince1970TwoYearsFromNow;
/** 根据输入的毫秒数返回具体时间 */
+ (NSDate*) dateFromMillisSince1970:(long long)interval;
/** 格式化毫秒数 */
+ (long long) millisDateOnlyFromMillisSince1970:(long long)interval;

+ (NSString*) birthdateDisplayStr:(long long) dateLong;
+ (BOOL) isValidBirthdate:(long long) dateLong;


+ (NSDate *)dateOfCurBuild;

- (NSString *)stringForFormat:(NSString *)format;

- (NSString*)dateStringMMMDYYYY;
- (NSString*)dateStringMMMDYYYYHideThisYear;
- (NSString*)dateStringMMMDYYYYHHMMHideThisYear;
- (NSString*)dateStringHHMMSS;
- (NSString*)dateStringVariableFormat;

- (BOOL)isLaterThan:(NSDate *)date;
@end
