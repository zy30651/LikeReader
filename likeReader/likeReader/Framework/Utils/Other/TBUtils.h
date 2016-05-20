//
//  TBUtils.h
//  Framework
//
//  Created by ZY on 16/4/12.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <Foundation/Foundation.h>


#define UIColorFromRGB_dec(r,g,b) [UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:1.f]

#define UIColorFromRGBA_dec(r,g,b,a) [UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]

#define UIColorFromRGB_hex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]


#define UIColorFromRGBA_hex(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define AtLeastIOS7 [TBUtils systemVersionAtLeastIOS7]
#define AtLeastIOS8 [TBUtils systemVersionAtLeastIOS8]
#define isScreen480 [TBUtils isScreenHeight480]
#define viewTopOffset (AtLeastIOS7?64:0)

@interface TBUtils : NSObject

/** CGFloat秒转化为String Example: [61 -> 01:01] */
+ (NSString *)convertTime:(CGFloat)second;
/** NavigationBarButton from Title */
+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)string withTarget:(id)target andSel:(SEL)sel;
/** NavigationBarButton from Image */
+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)img withTarget:(id)target andSel:(SEL)sel;

/** YY框架里边有NSString的 分类方法里面有SizeForFont方法 */
/*
 +(CGSize) oneLineTextSize:(NSString*)text withFont:(UIFont*) font maxSize:(CGSize)maxSize;
 +(CGSize) multiLineTextSize:(NSString*)text withFont:(UIFont*) font maxSize:(CGSize)maxSize;
 */

+ (BOOL)systemVersionAtLeastIOS7;
+ (BOOL)systemVersionAtLeastIOS8;
+ (BOOL)isScreenHeight480;
+ (BOOL)moreThanScreenHeight568;
+ (long long)timeIntervalWithDate:(NSDate *)date;

/** 获取文件大小 */
+ (CGFloat) getFileSize:(NSString *)path;
/** 等比例缩放 */
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;
+ (NSInteger)systemVersionBigVersion;


// country code
- (NSDictionary *)countryCodeInfoFromCountryNumber:(NSString *)number;
- (NSDictionary *)countryCodeInfoFromCurrentCarrier;

/** 获得视频时长 */
- (CGFloat)getVideoDurationBySecondWithString:(NSString *)path;
@end
