//
//  TBRefreshNormalHeader.m
//  TBRefresh
//
//  Created by ZY on 15/12/23.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshNormalHeader.h"

@interface TBRefreshNormalHeader()
{
    __weak UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation TBRefreshNormalHeader

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
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:TBRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != TBRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:TBRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == TBRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:TBRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == TBRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}
@end
