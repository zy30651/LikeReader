//
//  NSString+Add.h
//  likeReader
//
//  Created by ZY on 16/5/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
