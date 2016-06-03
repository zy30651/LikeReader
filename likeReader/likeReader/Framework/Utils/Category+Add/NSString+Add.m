//
//  NSString+Add.m
//  likeReader
//
//  Created by ZY on 16/5/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "NSString+Add.h"

long long const distantPastInMilliseconds = -7000000000000;

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
    UIButton *btn  = [[UIButton alloc]init];
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
    }];
    [btn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
    }];
    
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


- (BOOL)isValidateWithPredicstring:(NSString *)predicStr{
    NSPredicate *predic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicStr];
    return [predic evaluateWithObject:self];
}

- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateWithPredicstring:emailRegex];
}

-(long long) toMilliseconds
{
    if (0 == self.length)
    {
        return distantPastInMilliseconds;
    }
    return [self longLongValue];
}
@end
