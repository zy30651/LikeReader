//
//  UIView+Add.m
//  likeReader
//
//  Created by ZY on 16/5/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)



- (void)addTargetForTouch:(id)target action:(SEL)action
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:target action:action];
    [self addGestureRecognizer:singleTap];
    
}

@end
