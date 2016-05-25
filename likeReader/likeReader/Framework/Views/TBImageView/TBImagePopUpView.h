//
//  TBImagePopUpView.h
//  likeReader
//
//  Created by ZY on 16/5/25.
//  Copyright © 2016年 jack. All rights reserved.
//  全屏放大一个ImageView，支持放大后双击再放大

#import <UIKit/UIKit.h>

@interface TBImagePopUpView : UIView


/****originalFrame 原始图片所在的整个window的frame
 ****defaultImage  加载时候的默认图片
 ***originalUrl    加载的原始图片
 */
- (id)initWithOriginalFrame :(CGRect)originalFrame
                defaultImage:(UIImage *)defaultImage
                 OriginalUrl:(NSURL *) originalUrl;


/*
 *显示pop图片
 */
-(void)showPopImage;
@end
