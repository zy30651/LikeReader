//
//  NSString+Add.m
//  Framework
//
//  Created by ZY on 16/4/13.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "NSString+Add.h"

@implementation NSString (Add)

-(NSString*) stringByTrimmingFirstLastSaveMiddleReturn
{
    NSString* str = [self stringByTrimmingCharactersInSet:
                     [NSCharacterSet newlineCharacterSet]];
    return str;
}

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
