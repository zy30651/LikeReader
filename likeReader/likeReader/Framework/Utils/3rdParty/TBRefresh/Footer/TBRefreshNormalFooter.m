//
//  TBRefreshNormalFooter.m
//  TBRefresh
//
//  Created by ZY on 15/12/24.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshNormalFooter.h"

@interface TBRefreshNormalFooter()
{
    __weak UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation TBRefreshNormalFooter
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:TBRefreshSrcName(@"arrow.png")] ?: [UIImage imageNamed:TBRefreshFrameworkSrcName(@"arrow.png")];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}


- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}
#pragma makr - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.width * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 100;
    }
    CGFloat arrowCenterY = self.height * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}

- (void)setState:(TBRefreshState)state
{
    TBRefreshCheckState
    
    // 根据状态做事情
    if (state == TBRefreshStateIdle) {
        if (oldState == TBRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            [UIView animateWithDuration:TBRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                
                self.arrowView.hidden = NO;
            }];
        } else {
            self.arrowView.hidden = NO;
            [self.loadingView stopAnimating];
            [UIView animateWithDuration:TBRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
        }
    } else if (state == TBRefreshStatePulling) {
        self.arrowView.hidden = NO;
        [self.loadingView stopAnimating];
        [UIView animateWithDuration:TBRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformIdentity;
        }];
    } else if (state == TBRefreshStateRefreshing) {
        self.arrowView.hidden = YES;
        [self.loadingView startAnimating];
    } else if (state == TBRefreshStateNoMoreData) {
        self.arrowView.hidden = YES;
        [self.loadingView stopAnimating];
    }
}
@end
