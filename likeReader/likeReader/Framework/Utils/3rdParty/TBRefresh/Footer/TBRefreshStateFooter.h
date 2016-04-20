//
//  TBRefreshStateFooter.h
//  TBRefresh
//
//  Created by ZY on 15/12/24.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshFooter.h"

@interface TBRefreshStateFooter : TBRefreshFooter

/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;

/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(TBRefreshState)state;

/** 获取state状态下的title */
- (NSString *)titleForState:(TBRefreshState)state;
@end
