//
//  UIBarButtonItem+Add.m
//  likeReader
//
//  Created by ZY on 16/6/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "UIBarButtonItem+Add.h"

@implementation UIBarButtonItem (Add)


+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)string
                             withTarget:(id)target
                                 andSel:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.8] forState:UIControlStateNormal];
    [button setTitle:string forState:UIControlStateNormal];
    button.exclusiveTouch = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    CGSize btnSize = [string sizeForFont:button.titleLabel.font size:CGSizeMake(0.0, 40) mode:NSLineBreakByCharWrapping];
    button.frame = CGRectMake(0, 0, btnSize.width, btnSize.height);
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)img
                             withTarget:(id)target
                                 andSel:(SEL)sel
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    [button setBackgroundImage:img forState:UIControlStateNormal];
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
