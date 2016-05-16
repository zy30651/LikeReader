//
//  NSString+Add.m
//  likeReader
//
//  Created by ZY on 16/5/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "NSString+Add.h"

@implementation NSString (Add)

- (BOOL)isChineseChar{
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return YES;
    }
    return NO;
}

- (NSString *)firstCapitalLetterString{
    NSRange flRange = NSMakeRange(0, 1);
    NSString* fl = [self substringWithRange:flRange];
    NSString* flc = [fl capitalizedString];
    NSMutableString *ms = [NSMutableString stringWithString:self];
    [ms replaceCharactersInRange:flRange withString:flc];
    return ms;
}

- (NSString *)firstLowerCaseLetterString{
    NSRange flRange = NSMakeRange(0, 1);
    NSString* fl = [self substringWithRange:flRange];
    NSString* fll = [fl lowercaseString];
    NSMutableString *ms = [NSMutableString stringWithString:self];
    [ms replaceCharactersInRange:flRange withString:fll];
    return ms;
}

@end
