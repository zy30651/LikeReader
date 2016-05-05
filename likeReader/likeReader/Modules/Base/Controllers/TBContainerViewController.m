//
//  TBContainerViewController.m
//  JingHan
//
//  Created by ZY on 16/4/18.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBContainerViewController.h"

@implementation TBContainerViewController


-(void)loadView{
    [super loadView];
    [self preloadChildrenViewControllers];
    [self loadChildrenViewControllers];
}

-(void)loadChildrenViewControllers{
    // Subclasses to implement
}
-(void) preloadChildrenViewControllers{
    // Subclasses to implement
}
-(void)initFetchedResultsControllers{
    // Subclasses to implement
}
-(void) addChildViewController:(UIViewController *)childController{
    [super addChildViewController:childController];
    [self.view addSubview:childController.view];
    [childController didMoveToParentViewController:self];
}

-(void) addChildViewController:(UIViewController *)childController
                   toSuperView:(UIView*)superView
                     withFrame:(CGRect)frameForChild{
    [super addChildViewController:childController];
    childController.view.frame = frameForChild;
    if (!superView)
    {
        [self.view addSubview:childController.view];
    }
    else
    {
        [superView addSubview:childController.view];
    }
    
    [childController didMoveToParentViewController:self];
}

-(void) removeChildViewController:(UIViewController*)childController{
    [childController willMoveToParentViewController:nil];
    [childController.view removeFromSuperview];
}


@end
