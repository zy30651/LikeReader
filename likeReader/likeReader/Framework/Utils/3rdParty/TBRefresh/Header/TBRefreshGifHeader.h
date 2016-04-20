//
//  TBRefreshGitHeader.h
//  TBRefresh
//
//  Created by ZY on 15/12/23.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshStateHeader.h"

@interface TBRefreshGifHeader : TBRefreshStateHeader

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(TBRefreshState)state;
- (void)setImages:(NSArray *)images forState:(TBRefreshState)state;

@end
