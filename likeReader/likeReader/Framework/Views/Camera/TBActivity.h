//
//  TBActivity.h
//  likeReader
//
//  Created by ZY on 16/6/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBActivity : UIView

@property (nonatomic, strong) UIColor *activityBackColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic,assign) CGFloat LXActivityHeight;


- (id)initWithTitle:(NSString *)title
  cancelButtonTitle:(NSString *)cancelButtonTitle
  ShareButtonTitles:(NSArray *)shareButtonTitlesArray
   normalImagesName:(NSArray *)normalImagesNameArray
highlightImagesName:(NSArray *)highlightImagesNameArray
   shareButtonColor:(UIColor *)shareColor;

- (void)showInView:(UIView *)view onComplete:(void (^)(NSInteger index))complete;
- (UIButton *)cancelButton;

@end
