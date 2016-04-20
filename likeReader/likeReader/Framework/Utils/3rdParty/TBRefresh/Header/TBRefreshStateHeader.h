//
//  TBRefreshStateHeader.h
//  TBRefresh
//
//  Created by ZY on 15/12/23.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshHeader.h"

@interface TBRefreshStateHeader : TBRefreshHeader
#pragma mark - 刷新时间相关
@property (nonatomic, copy)NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);
@property (nonatomic, weak, readonly)UILabel *lastUpdatedTimeLabel;

#pragma mark - 状态相关
@property (nonatomic, weak, readonly)UILabel *stateLabel;
- (void)setTitle:(NSString *)title forState:(TBRefreshState)state;
@end
