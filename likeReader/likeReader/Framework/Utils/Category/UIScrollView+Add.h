//
//  UIScrollView+TBRefresh.h
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBRefreshFooter,TBRefreshHeader;

@interface UIScrollView (Add)

@property (nonatomic, strong)TBRefreshHeader *header;
@property (nonatomic, strong)TBRefreshFooter *footer;

-(NSInteger)totalDataCount;
@property (nonatomic, copy) void (^TB_reloadDataBlock)(NSInteger totalDataCount);

@property (assign, nonatomic) CGFloat contentInsetTop;
@property (assign, nonatomic) CGFloat contentInsetBottom;
@property (assign, nonatomic) CGFloat contentInsetLeft;
@property (assign, nonatomic) CGFloat contentInsetRight;

@property (assign, nonatomic) CGFloat contentOffsetX;
@property (assign, nonatomic) CGFloat contentOffsetY;

@property (assign, nonatomic) CGFloat contentSizeWidth;
@property (assign, nonatomic) CGFloat contentSizeHeight;
@end
