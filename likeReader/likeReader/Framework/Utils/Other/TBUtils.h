//
//  TBUtils.h
//  Framework
//
//  Created by ZY on 16/4/12.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <Foundation/Foundation.h>


#define AtLeastIOS7 [LBUtils systemVersionAtLeastIOS7]
#define AtLeastIOS8 [LBUtils systemVersionAtLeastIOS8]
#define isScreen480 [LBUtils isScreenHeight480]
#define viewTopOffset (AtLeastIOS7?64:0)

@interface TBUtils : NSObject
/** CGFloat秒转化为String Example: [61 -> 01:01] */
+ (NSString *)convertTime:(CGFloat)second;
/** NavigationBarButton from Title */
+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)string withTarget:(id)target andSel:(SEL)sel;
/** NavigationBarButton from Image */
+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)img withTarget:(id)target andSel:(SEL)sel;

+(CGSize) oneLineTextSize:(NSString*)text withFont:(UIFont*) font maxSize:(CGSize)maxSize;
+(CGSize) multiLineTextSize:(NSString*)text withFont:(UIFont*) font maxSize:(CGSize)maxSize;

+ (BOOL)systemVersionAtLeastIOS7;
+ (BOOL)systemVersionAtLeastIOS8;
+ (BOOL)isScreenHeight480;
+ (BOOL)moreThanScreenHeight568;
+ (long long)timeIntervalWithDate:(NSDate *)date;

- (BOOL)isValidateEmail;
@end
