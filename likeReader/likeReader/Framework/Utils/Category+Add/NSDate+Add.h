//
//  NSDate+Add.h
//  likeReader
//
//  Created by ZY on 16/5/27.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Add)

/** 返回1970年到现在多有年份 */
+ (NSArray*)arrayYearStringsFrom1970;

/** <#属性注释#> */
+ (NSDate *)dateWithFormat:(NSString *)format
             andDateString:(NSString *)strDate;

/** <#属性注释#> */
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day;

/** 返回1970年到现在的毫秒数 */
- (long long)millisecondsSince1970;


+ (NSDate *)dateOfCurBuild;

- (NSString *)stringForFormat:(NSString *)format;

- (NSString*)dateStringMMMDYYYY;
- (NSString*)dateStringMMMDYYYYHideThisYear;
- (NSString*)dateStringMMMDYYYYHHMMHideThisYear;
- (NSString*)dateStringHHMMSS;
- (NSString*)dateStringVariableFormat;

- (BOOL)isLaterThan:(NSDate *)date;
@end
