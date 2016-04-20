//
//  TBNavigationVC.m
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBNavigationVC.h"

@interface TBNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation TBNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}
//iOS7,默认应该就支持右滑返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}

@end
