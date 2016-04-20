//
//  TBCommon.h
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//


#define TBRefreshHeaderHeight  54.0 
#define TBRefreshFooterHeight  44.0 
#define TBRefreshFastAnimationDuration  0.25 
#define TBRefreshSlowAnimationDuration  0.4 

#define TBRefreshKeyPathContentOffset  @"contentOffset" 
#define TBRefreshKeyPathContentInset  @"contentInset" 
#define TBRefreshKeyPathContentSize  @"contentSize" 
#define TBRefreshKeyPathPanState  @"state" 

#define TBRefreshHeaderLastUpdatedTimeKey  @"TBRefreshHeaderLastUpdatedTimeKey" 

#define TBRefreshHeaderIdleText  @"下拉可以刷新" 
#define TBRefreshHeaderPullingText  @"松开立即刷新" 
#define TBRefreshHeaderRefreshingText  @"正在刷新数据中..." 

#define TBRefreshAutoFooterIdleText  @"点击或上拉加载更多" 
#define TBRefreshAutoFooterRefreshingText  @"正在加载更多的数据..." 
#define TBRefreshAutoFooterNoMoreDataText  @"已经全部加载完毕" 

#define TBRefreshBackFooterIdleText  @"上拉可以加载更多" 
#define TBRefreshBackFooterPullingText  @"松开立即加载更多" 
#define TBRefreshBackFooterRefreshingText  @"正在加载更多的数据..." 
#define TBRefreshBackFooterNoMoreDataText  @"已经全部加载完毕" 

// 图片路径
#define TBRefreshSrcName(file) [@"TBRefresh.bundle" stringByAppendingPathComponent:file]
#define TBRefreshFrameworkSrcName(file) [@"Frameworks/TBRefresh.framework/TBRefresh.bundle" stringByAppendingPathComponent:file]

// 状态检查
#define TBRefreshCheckState \
TBRefreshState oldState = self.state;  \
if (state == oldState) return;  \
[super setState:state];

