//
//  NSString+Add.h
//  Framework
//
//  Created by ZY on 16/4/13.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Add)

/** 保留空格，删除头尾换行 */
- (NSString *)stringByTrimmingFirstLastSaveMiddleReturn;
/** 首字母大写 */
- (NSString *)firstCapitalLetterString;
/** 首字母小写 */
- (NSString *)firstLowerCaseLetterString;
/** 是否是汉字 */
- (BOOL)isChineseChar;

@end
