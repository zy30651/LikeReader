//
//  UIView+Add.h
//  likeReader
//
//  Created by ZY on 16/5/16.
//  Copyright © 2016年 jack. All rights reserved.
//  之前原有的BUIView，是针对UIAlertView和UIActionSheet的封装。iOS8之后这两个View已经过期。所以在此遗弃.

#import <UIKit/UIKit.h>

@interface UIView (Add)


/**
 * Shortcut for frame.size.witdth*0.5
 */
@property (nonatomic,readonly) CGFloat inCenterX;
/**
 * Shortcut for frame.size.height*0.5
 */
@property (nonatomic,readonly) CGFloat inCenterY;

/**
 * Shortcut for CGPointMake(self.inCenterX,self.inCenterY)
 */
@property (nonatomic,readonly) CGPoint inCenter;
/**
 * Shortcut for bounds.size.width
 *
 * Sets bounds.size.width = width
 */
@property (nonatomic,readonly) CGFloat b_width;
@property (nonatomic, assign) CGFloat b_x;
@property (nonatomic, assign) CGFloat b_y;

/**
 * Shortcut for bounds.size.height
 *
 * Sets bounds.size.height = height
 */
@property (nonatomic,readonly) CGFloat b_height;
/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;


- (void)addTargetForTouch:(id)target action:(SEL)action;
// 抓图：当前view的图或者被其所遮挡的部分的图;
-(UIImage *)captureWithSelfContent:(BOOL)bWithSelf;
// 抓取当前view的截图;
-(UIImage *)captureSelf;



- (UIImage*)screenshotWithOptimization:(BOOL)optimized;
- (UIImage*)screenshot;
@end
