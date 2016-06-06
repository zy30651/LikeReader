//
//  TBShowHUD.h
//  likeReader
//
//  Created by ZY on 16/6/6.
//  Copyright © 2016年 jack. All rights reserved.
//
#import "JPEngine.h"
#import "MBProgressHUD.h"
#import <Foundation/Foundation.h>
@class TBShowHUD;

typedef void (^ConfigShowHUDBlock)(TBShowHUD *config);
typedef UIView *(^ConfigShowHUDCustomViewBlock)();

typedef enum {
    Fade = MBProgressHUDAnimationFade,
    Zoom = MBProgressHUDAnimationZoom,
    ZoomOut = MBProgressHUDAnimationZoomOut,
    ZoomIn = MBProgressHUDAnimationZoomIn
}HUDAnimationType;

@interface TBShowHUD : NSObject
/** 动画效果 */
@property (nonatomic, assign) HUDAnimationType animationStyle;
/** 文本(默认菊花) */
@property (nonatomic, strong) NSString *text;
/** 文本字体 */
@property (nonatomic, strong) UIFont *textFont;
/** 自定义View */
@property (nonatomic, strong) UIView *customView;
/** 只显示文本的相关设置 */
@property (nonatomic, assign) BOOL showTextOnly;
/** 边缘留白 */
@property (nonatomic, assign) float margin;
/** 背景颜色设置-设置颜色，透明度失效 */
@property (nonatomic, strong) UIColor *backgroundColor;
/** 文本颜色设置-设置颜色，透明度失效 */
@property (nonatomic, strong) UIColor *labelColor;
/** 透明度 */
@property (nonatomic, assign) float opacity;
/** 圆角 */
@property (nonatomic, assign) float cornerRadius;


// 仅仅显示文本并持续几秒的方法
/* - 使用示例 -
 [ShowHUD showTextOnly:@"请稍后,显示不了..."
 configParameter:^(ShowHUD *config) {
 config.margin          = 10.f;    // 边缘留白
 config.opacity         = 0.7f;    // 设定透明度
 config.cornerRadius    = 2.f;     // 设定圆角
 } duration:3 inView:self.view];
 */
+ (void)showTextOnly:(NSString *)text
     configParameter:(ConfigShowHUDBlock)config
            duration:(NSTimeInterval)sec
              inView:(UIView *)view;


// 显示文本与菊花并持续几秒的方法(文本为nil时只显示菊花)
/* - 使用示例 -
 [ShowHUD showText:@"请稍后,显示不了..."
 configParameter:^(ShowHUD *config) {
 config.margin          = 10.f;    // 边缘留白
 config.opacity         = 0.7f;    // 设定透明度
 config.cornerRadius    = 2.f;     // 设定圆角
 } duration:3 inView:self.view];
 */
+(void)showText:(NSString *)text
configParameter:(ConfigShowHUDBlock)config
       duration:(NSTimeInterval)sec
         inView:(UIView *)view;



// 加载自定义view并持续几秒的方法
/* - 使用示例 -
 [ShowHUD showText:@"请稍后,显示不了..."
 configParameter:^(ShowHUD *config) {
 config.margin          = 10.f;    // 边缘留白
 config.opacity         = 0.7f;    // 设定透明度
 config.cornerRadius    = 2.f;     // 设定圆角
 } duration:3 inView:self.view];
 */
+ (void)showCustomView:(ConfigShowHUDCustomViewBlock)viewBlock
       configParameter:(ConfigShowHUDBlock)config
              duration:(NSTimeInterval)sec
                inView:(UIView *)view;


/**
 *  下面几个方法没有时间设置，用于网络请求，返回后根据instancetype hide hud
 */
+ (instancetype)showTextOnly:(NSString *)text
             configParameter:(ConfigShowHUDBlock)config
                      inView:(UIView *)view;
+ (instancetype)showText:(NSString *)text
         configParameter:(ConfigShowHUDBlock)config
                  inView:(UIView *)view;
+ (instancetype)showCustomView:(ConfigShowHUDCustomViewBlock)viewBlock
               configParameter:(ConfigShowHUDBlock)config
                        inView:(UIView *)view;
- (void)hide;

@end
