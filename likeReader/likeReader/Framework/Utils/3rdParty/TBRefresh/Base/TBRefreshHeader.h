//
//  TBRefreshHeader.h
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBRefreshComponent.h"

@interface TBRefreshHeader : TBRefreshComponent

+ (instancetype)headerWithRefreshingBlock:(TBRefreshComponentRefreshingBlock)refreshingBlock;
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@property (nonatomic, copy)NSString *lastUpdatedTimeKey;
@property (nonatomic, strong, readonly)NSDate *lastUpdatedTime;

@property (nonatomic, assign)CGFloat ignoredScrollViewContentInsetTop;
@end
