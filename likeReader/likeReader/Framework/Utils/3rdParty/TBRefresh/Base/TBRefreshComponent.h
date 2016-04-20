//
//  TBRefreshComponent.h
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Add.h"
#import "UIView+Add.h"
#import "TBRefreshCommon.h"

typedef NS_ENUM(NSInteger,TBRefreshState) {
    /** 普通闲置状态 */
    TBRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    TBRefreshStatePulling,
    /** 正在刷新中的状态 */
    TBRefreshStateRefreshing,
    /** 即将刷新的状态 */
    TBRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    TBRefreshStateNoMoreData
};

typedef void (^TBRefreshComponentRefreshingBlock)();

@interface TBRefreshComponent : UIView
{
    UIEdgeInsets _scrollViewOriginalInset;
    __weak UIScrollView *_scrollView;
}
#pragma mark - 刷新回调
/**
 *  正在刷新的回调
 */
@property (nonatomic, copy)TBRefreshComponentRefreshingBlock refreshingBlock;
/**
 *  设置回调对象和回调方法
 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
/**
 *  回调对象
 */
@property (nonatomic, weak)id refreshingTarget;
/**
 *  回调方法
 */
@property (nonatomic, assign)SEL refreshingAction;
/**
 *  触发回调（交给子类调用）
 */
-(void)executeRefreshingCallback;

#pragma mark - 刷新状态控制
/**
 *  进入刷新状态
 */
- (void)beginRefreshing;
/**
 *  结束刷新状态
 */
- (void)endRefreshing;
/**
 *  是否正在刷新
 */
- (BOOL)isRefreshing;
/**
 *  刷新状态(一般交给子类实现)
 */
@property (nonatomic, assign)TBRefreshState state;
#pragma mark - 交给子类访问
/**
 *  记录scrollView刚开始的inset
 */
@property (nonatomic,assign,readonly)UIEdgeInsets scrollViewOriginalInset;
/**
 *  父控件
 */
@property (nonatomic,weak,readonly)UIScrollView *scrollView;
#pragma mark - 交给子类实现
/**
 *  初始化     NS_REQUIRES_SUPER要求子类重写父类的时候必须调用Super 方法
 */
- (void)prepare NS_REQUIRES_SUPER;
/**
 *  摆放子控件Frame
 */
- (void)placeSubviews NS_REQUIRES_SUPER;

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;

#pragma mark - 其他

/** 拉拽的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;
/** 根据拖拽比例自动切换透明度 */
@property (assign, nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;

@end

@interface UILabel(MJRefresh)
+ (instancetype)label;
@end