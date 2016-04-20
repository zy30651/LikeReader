//
//  TBRefreshStateFooter.m
//  TBRefresh
//
//  Created by ZY on 15/12/24.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshStateFooter.h"

@interface TBRefreshStateFooter()
{
    /** 显示刷新状态的label */
    __weak UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@property (assign, nonatomic) NSInteger lastRefreshCount;
@property (assign, nonatomic) CGFloat lastBottomDelta;

@end

@implementation TBRefreshStateFooter
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label]];
    }
    return _stateLabel;
}

#pragma mark - 初始化
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self scrollViewContentSizeDidChange:nil];
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(TBRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (NSString *)titleForState:(TBRefreshState)state
{
    return self.stateTitles[@(state)];
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化文字
    [self setTitle:TBRefreshBackFooterIdleText forState:TBRefreshStateIdle];
    [self setTitle:TBRefreshBackFooterPullingText forState:TBRefreshStatePulling];
    [self setTitle:TBRefreshBackFooterRefreshingText forState:TBRefreshStateRefreshing];
    [self setTitle:TBRefreshBackFooterNoMoreDataText forState:TBRefreshStateNoMoreData];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.constraints.count) return;
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果正在刷新，直接返回
    if (self.state == TBRefreshStateRefreshing) return;
    
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.contentOffsetY;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) return;
    
    CGFloat pullingPercent = (currentOffsetY - happenOffsetY) / self.height;
    
    // 如果已全部加载，仅设置pullingPercent，然后返回
    if (self.state == TBRefreshStateNoMoreData) {
        self.pullingPercent = pullingPercent;
        return;
    }
    
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + self.height;
        
        if (self.state == TBRefreshStateIdle && currentOffsetY > normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = TBRefreshStatePulling;
        } else if (self.state == TBRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = TBRefreshStateIdle;
        }
    } else if (self.state == TBRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.contentSizeHeight + self.ignoredScrollViewContentInsetBottom;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
    // 设置位置和尺寸
    self.top = MAX(contentHeight, scrollHeight);
}

- (void)setState:(TBRefreshState)state
{
    TBRefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    // 根据状态来设置属性
    if (state == TBRefreshStateNoMoreData || state == TBRefreshStateIdle) {
        // 刷新完毕
        if (TBRefreshStateRefreshing == oldState) {
            [UIView animateWithDuration:TBRefreshSlowAnimationDuration animations:^{
                self.scrollView.contentInsetBottom -= self.lastBottomDelta;
                
                // 自动调整透明度
                if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
            }];
        }
        
        CGFloat deltaH = [self heightForContentBreakView];
        // 刚刷新完毕
        if (TBRefreshStateRefreshing == oldState && deltaH > 0 && self.scrollView.totalDataCount != self.lastRefreshCount) {
            self.scrollView.contentOffsetY = self.scrollView.contentOffsetY;
        }
    } else if (state == TBRefreshStateRefreshing) {
        // 记录刷新前的数量
        self.lastRefreshCount = self.scrollView.totalDataCount;
        
        [UIView animateWithDuration:TBRefreshFastAnimationDuration animations:^{
            CGFloat bottom = self.height + self.scrollViewOriginalInset.bottom;
            CGFloat deltaH = [self heightForContentBreakView];
            if (deltaH < 0) { // 如果内容高度小于view的高度
                bottom -= deltaH;
            }
            self.lastBottomDelta = bottom - self.scrollView.contentInsetBottom;
            self.scrollView.contentInsetBottom = bottom;
            self.scrollView.contentOffsetY = [self happenOffsetY] + self.height;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    }
}

#pragma mark - 公共方法
- (void)endRefreshing
{
    if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [super endRefreshing];
        });
    } else {
        [super endRefreshing];
    }
}

#pragma mark - 私有方法
#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}

@end
