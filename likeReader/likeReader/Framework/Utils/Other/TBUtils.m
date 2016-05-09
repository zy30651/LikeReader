//
//  TBUtils.m
//  Framework
//
//  Created by ZY on 16/4/12.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBUtils.h"

@implementation TBUtils


+(NSString *)convertTime:(CGFloat)second
{
    second = second < 0 ? 0 : second;
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    //    NSLog(@"%f-----%@----%@",second,d,showtimeNew);
    return showtimeNew;
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)string withTarget:(id)target andSel:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.8] forState:UIControlStateNormal];
    [button setTitle:string forState:UIControlStateNormal];
    button.exclusiveTouch = YES;
    UIFont *strFont = [UIFont boldSystemFontOfSize:16.0];
    button.titleLabel.font = strFont;
    button.frame = CGRectMake(0, 0, [string widthForFont:strFont] + 10, button.titleLabel.font.pointSize + 2);
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)img withTarget:(id)target andSel:(SEL)sel
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    [button setBackgroundImage:img forState:UIControlStateNormal];
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (BOOL)systemVersionAtLeastIOS7
{
    BOOL iOS7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?YES:NO;
    return iOS7;
}
+ (BOOL)systemVersionAtLeastIOS8{
    BOOL iOS8 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0?YES:NO;
    return iOS8;
}

+ (BOOL)isScreenHeight480
{
    return MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 480;
}
+ (BOOL)moreThanScreenHeight568
{
    return MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) > 568;
}

+ (long long)timeIntervalWithDate:(NSDate *)date
{
    if (![date isKindOfClass:[NSDate class]])
    {
        return -7000000000000;
    }
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSNumber* num = [NSNumber numberWithDouble:timeInterval * 1000];
    long long timeMillis = [num longLongValue];
    return timeMillis;
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
@end
