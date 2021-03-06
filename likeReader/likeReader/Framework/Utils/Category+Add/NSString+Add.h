//
//  NSString+Add.h
//  likeReader
//
//  Created by ZY on 16/5/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

extern long long const distantPastInMilliseconds;

@interface NSString (Add)

/**
 Returns YES if the char is  chineseChar.
 */
- (BOOL)isChineseChar;

/**
 abcdEFG   ---> AbcdEFG.
 
 @return A new string And first char is Capital Letter.
 */
- (NSString *)firstCapitalLetterString;

/**
 AbcdEFG   ---> abcdEFG.
 
 @return A new string And first char is LowerCase Letter.
 */
- (NSString *)firstLowerCaseLetterString;


- (BOOL)isValidateWithPredicstring:(NSString *)predicStr;

- (BOOL)isValidateEmail;

- (long long) toMilliseconds;
@end
