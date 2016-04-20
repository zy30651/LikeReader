//
//  TBRefreshFooter.m
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshFooter.h"

@implementation TBRefreshFooter

#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(TBRefreshComponentRefreshingBlock)refreshingBlock
{
    TBRefreshFooter *footer = [[self alloc] init];
    footer.refreshingBlock = refreshingBlock;
    return footer;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    TBRefreshFooter *footer = [[self alloc] init];
    [footer setRefreshingTarget:target refreshingAction:action];
    return footer;
}

#pragma mark - 重写父类方法
-(void)prepare
{
    [super prepare];
    self.height = TBRefreshFooterHeight;
    self.automaticallyHidden = YES;
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        if ([self.scrollView isKindOfClass:[UITableView class]] ||
            [self.scrollView isKindOfClass:[UICollectionView class]])
        {
            [self.scrollView setTB_reloadDataBlock:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount == 0);
                }
            }];
        }
    }
}
#pragma mark - 公共方法
-(void)endRefreshingWithNoMoreData
{
    self.state = TBRefreshStateNoMoreData;
}
-(void)resetNoMoreData
{
    self.state = TBRefreshStateIdle;
}
@end
