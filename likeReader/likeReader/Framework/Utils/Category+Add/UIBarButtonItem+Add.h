//
//  UIBarButtonItem+Add.h
//  likeReader
//
//  Created by ZY on 16/6/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Add)


+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)string
                             withTarget:(id)target
                                 andSel:(SEL)sel;
+ (UIBarButtonItem *)barButtonWithImage:(UIImage *)img
                             withTarget:(id)target
                                 andSel:(SEL)sel;


@end
