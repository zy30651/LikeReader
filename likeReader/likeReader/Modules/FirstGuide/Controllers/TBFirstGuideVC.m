//
//  TBFirstGuideVC.m
//  JingHan
//
//  Created by ZY on 16/4/18.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "TBTabbarVC.h"
#import "TBFirstGuideVC.h"
#import "TBFirstGuideStep1VC.h"
#import "TBFirstGuideStep2VC.h"


@implementation TBFirstGuideVC

#pragma mark - UIViewController
-(void)performViewDidLoadSequence{
    [super performViewDidLoadSequence];
    TBFirstGuideStep1VC *step1VC = [[TBFirstGuideStep1VC alloc]init];
    [self addChildViewController:step1VC];
    
    TBFirstGuideStep2VC *step2VC = [[TBFirstGuideStep2VC alloc]init];
    [self addChildViewController:step2VC];
    
    [self.view addSubview:step1VC.view];
    
    __weak __typeof(&*step1VC)weakStep1 = step1VC;
    step1VC.onNext = ^(){
        [self transitionFromViewController:weakStep1 toViewController:step2VC duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
    };
    step2VC.onNext = ^(){
        TBTabbarVC *tabbarVC = [TBTabbarVC tabBarController];
        [UIApplication sharedApplication].delegate.window.rootViewController = tabbarVC;
    };
}

@end
