//
//  TBRefreshNormalHeader.h
//  TBRefresh
//
//  Created by ZY on 15/12/23.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//

#import "TBRefreshStateHeader.h"

@interface TBRefreshNormalHeader : TBRefreshStateHeader

@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@end
