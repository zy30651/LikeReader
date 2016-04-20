//
//  UIScrollView+TBRefresh.m
//  TBRefresh
//
//  Created by ZY on 15/12/22.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "UIScrollView+Add.h"
#import "TBRefreshFooter.h"
#import "TBRefreshHeader.h"
#import <objc/runtime.h>
#import "NSObject+Add.h"

@implementation UIScrollView (Add)

static const char TBRefreshHeaderKey = '\0';
static const char TBRefreshFooterKey = '\0';

-(void)setHeader:(TBRefreshHeader *)header
{
    if (header != self.header) {
        [self.header removeFromSuperview];
        [self insertSubview:header atIndex:0];
        
        [self willChangeValueForKey:@"header"];
        objc_setAssociatedObject(self, &TBRefreshHeaderKey, header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"];
    }
}

-(TBRefreshHeader *)header
{
   return objc_getAssociatedObject(self, &TBRefreshHeaderKey);
}

-(void)setFooter:(TBRefreshFooter *)footer
{
    if (footer != self.footer) {
        [self.footer removeFromSuperview];
        [self insertSubview:footer atIndex:0];
        
        [self willChangeValueForKey:@"footer"];
        objc_setAssociatedObject(self, &TBRefreshFooterKey, footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"];
    }
}
-(TBRefreshFooter *)footer
{
    return objc_getAssociatedObject(self, &TBRefreshFooterKey);
}


#pragma mark -other
-(NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]])
    {
        UITableView* tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++)
        {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    }else if ([self isKindOfClass:[UICollectionView class]])
    {
        UICollectionView * collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++)
        {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char TBRefreshReloadDataBlockKey = '\0';

-(void)setTB_reloadDataBlock:(void (^)(NSInteger totalDataCount))TB_reloadDataBlock
{
    [self willChangeValueForKey:@"TB_reloadDataBlock"];
    objc_setAssociatedObject(self, &TBRefreshReloadDataBlockKey, TB_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"TB_reloadDataBlock"];
}
-(void (^)(NSInteger))TB_reloadDataBlock
{
    return objc_getAssociatedObject(self, &TBRefreshReloadDataBlockKey);
}

-(void)executeReloadDataBlock
{
    !self.TB_reloadDataBlock ? : self.TB_reloadDataBlock(self.totalDataCount);
}

- (void)setContentInsetTop:(CGFloat)contentInsetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)contentInsetTop
{
    return self.contentInset.top;
}

- (void)setContentInsetBottom:(CGFloat)contentInsetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)contentInsetBottom
{
    return self.contentInset.bottom;
}

- (void)setContentInsetLeft:(CGFloat)contentInsetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)contentInsetLeft
{
    return self.contentInset.left;
}

- (void)setContentInsetRight:(CGFloat)contentInsetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)contentInsetRight
{
    return self.contentInset.right;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setContentSizeWidth:(CGFloat)contentSizeWidth
{
    CGSize size = self.contentSize;
    size.width = contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}

- (void)setContentSizeHeight:(CGFloat)contentSizeHeight
{
    CGSize size = self.contentSize;
    size.height = contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}


@end

@implementation UITableView (TBRefresh)

+(void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(TB_reloadData)];
}
-(void)TB_reloadData
{
    [self TB_reloadData];
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (TBRefresh)

+(void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(TB_reloadData)];
}
-(void)TB_reloadData
{
    [self TB_reloadData];
    [self executeReloadDataBlock];
}

@end
