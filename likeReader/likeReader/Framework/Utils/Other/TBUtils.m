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

+ (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024/1024;
        return filesize;
    }
    return filesize;
}

+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage
{
    if (sourceImage.size.width < 640.0f) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = 640.0f;
        btWidth = sourceImage.size.width * (640.0f / sourceImage.size.height);
    } else {
        btWidth = 640.0f;
        btHeight = sourceImage.size.height * (640.0f / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


+ (NSInteger)systemVersionBigVersion
{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSRange bigVersionRange = [systemVersion rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSString* bigVersionStr = [systemVersion substringToIndex:bigVersionRange.location];
    NSInteger bigVersion = [bigVersionStr integerValue];
    return bigVersion;
}

//[self classSwizzle:self Method:@selector(drawRect:) withMethod:@selector(override_drawRect:)];
- (void)classSwizzle:(Class)c Method:(SEL)origSel withMethod:(SEL)overrideSel{
    Method origMethod = class_getInstanceMethod(c, origSel);
    Method overrideMethod= class_getInstanceMethod(c, overrideSel);
    if(class_addMethod(c, origSel, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)))
        class_replaceMethod(c,overrideSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod,overrideMethod);
    
}
@end
