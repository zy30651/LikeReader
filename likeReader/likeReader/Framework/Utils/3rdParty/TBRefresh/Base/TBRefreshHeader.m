//
//  TBRefreshHeader.m
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshHeader.h"
@interface TBRefreshHeader()

@property (nonatomic, assign) CGFloat insetTopDelta;

@end

@implementation TBRefreshHeader

#pragma mark - 构造方法
+(instancetype)headerWithRefreshingBlock:(TBRefreshComponentRefreshingBlock)refreshingBlock
{
    TBRefreshHeader *header = [[self alloc]init];
    header.refreshingBlock = refreshingBlock;
    return header;
}
+(instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    TBRefreshHeader *header = [[self alloc]init];
    [header setRefreshingTarget:target refreshingAction:action];
    return header;
}

#pragma mark - 覆盖父类的方法
-(void)prepare
{
    [super prepare];
    
    self.lastUpdatedTimeKey = TBRefreshHeaderLastUpdatedTimeKey;
    self.height = TBRefreshHeaderHeight;
}
-(void)placeSubviews
{
    [super placeSubviews];
    self.top = - self.height - self.ignoredScrollViewContentInsetTop;
}
-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state == TBRefreshStateRefreshing)
    {
        if (self.window == nil) return;
        
        CGFloat insetTop = -self.scrollView.contentOffsetY > _scrollViewOriginalInset.top ? -self.scrollView.contentOffsetY : _scrollViewOriginalInset.top;
        
        insetTop = insetTop > self.height + _scrollViewOriginalInset.top ? self.height + _scrollViewOriginalInset.top : insetTop;
        self.scrollView.contentInsetTop = insetTop;
        
        self.insetTopDelta = _scrollViewOriginalInset.top - insetTop;
        
        return;
    }
    
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    CGFloat offsetY = self.scrollView.contentOffsetY;
    CGFloat happenOffsetY = -self.scrollViewOriginalInset.top;
    if (offsetY > happenOffsetY) return;
    
    CGFloat normal2PullingOffsetY = happenOffsetY - self.height;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.height;
    
    if (self.scrollView.isDragging)
    {
        self.pullingPercent = pullingPercent;
        if (self.state == TBRefreshStateIdle && offsetY < normal2PullingOffsetY) {
            self.state = TBRefreshStatePulling;
        }else if (self.state == TBRefreshStatePulling && offsetY > normal2PullingOffsetY){
            self.state = TBRefreshStateIdle;
        }
    }else if (self.state == TBRefreshStatePulling)
    {
        [self beginRefreshing];
    }else if (pullingPercent < 1)
    {
        self.pullingPercent = pullingPercent;
    }
}

-(void)setState:(TBRefreshState)state
{
    TBRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    if (state == TBRefreshStateIdle)
    {
        if (oldState != TBRefreshStateRefreshing) return;
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [UIView animateWithDuration:TBRefreshFastAnimationDuration animations:^{
            self.scrollView.contentInsetTop += self.insetTopDelta;
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
        }];
    }else if (state == TBRefreshStateRefreshing){
        [UIView animateWithDuration:TBRefreshFastAnimationDuration animations:^{
            CGFloat top = self.scrollViewOriginalInset.top + self.height;
            self.scrollView.contentInsetTop = top;
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    }
}

#pragma mark - 公共方法
-(void)endRefreshing
{
    if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [super endRefreshing];
        });
    }else{
        [super endRefreshing];
    }
}
-(NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:self.lastUpdatedTimeKey];
}
@end

