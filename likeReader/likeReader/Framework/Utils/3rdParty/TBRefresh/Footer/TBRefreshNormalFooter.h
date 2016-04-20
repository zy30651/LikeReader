//
//  TBRefreshNormalFooter.h
//  TBRefresh
//
//  Created by ZY on 15/12/24.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshStateFooter.h"

@interface TBRefreshNormalFooter : TBRefreshStateFooter

@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@end
