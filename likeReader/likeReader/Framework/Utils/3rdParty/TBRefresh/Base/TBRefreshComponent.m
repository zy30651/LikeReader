//
//  TBRefreshComponent.m
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshComponent.h"
#import <objc/message.h>

@interface TBRefreshComponent()
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@end

@implementation TBRefreshComponent

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
        self.state = TBRefreshStateIdle;
    }
    return self;
}

-(void)prepare
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor  = [UIColor clearColor];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self placeSubviews];
}
-(void)placeSubviews{}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    [self removeObservers];
    
    if (newSuperview) {
        self.width = newSuperview.width;
        self.left = 0;
        
        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        [self addObservers];
    }
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.state == TBRefreshStateWillRefresh)
    {
        self.state = TBRefreshStateRefreshing;
    }
}

-(void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:TBRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:TBRefreshKeyPathContentSize options:options context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:TBRefreshKeyPathContentSize options:options context:nil];
}
-(void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:TBRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:TBRefreshKeyPathContentSize];;
    [self.pan removeObserver:self forKeyPath:TBRefreshKeyPathPanState];
    self.pan = nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (!self.userInteractionEnabled) return;
    if ([keyPath isEqualToString:TBRefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    if (self.hidden) return;
    if ([keyPath isEqualToString:TBRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
    if ([keyPath isEqualToString:TBRefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

#pragma mark 设置回调对象和回调方法
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    self.refreshingTarget = target;
    self.refreshingAction = action;
}

-(void)beginRefreshing
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;
    
    if (self.window) {
        self.state = TBRefreshStateRefreshing;
    }else{
        self.state = TBRefreshStateWillRefresh;
        [self setNeedsDisplay];
    }
}
-(void)endRefreshing
{
    self.state = TBRefreshStateIdle;
}
-(BOOL)isRefreshing
{
    return self.state == TBRefreshStateRefreshing || self.state == TBRefreshStateWillRefresh;
}

#pragma mark 自动切换透明度
-(void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha
{
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    if (self.isRefreshing) return;
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    }else{
        self.alpha = 1.0;
    }
}

#pragma mark - 内部方法
-(void)executeRefreshingCallback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            objc_msgSend(self.refreshingTarget,self.refreshingAction,self);
        }
    });
}

@end

@implementation UILabel(MJRefresh)
+ (instancetype)label
{
    UILabel *label = [[self alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
@end