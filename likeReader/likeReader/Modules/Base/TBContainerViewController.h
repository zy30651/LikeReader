//
//  TBContainerViewController.h
//  JingHan
//
//  Created by ZY on 16/4/18.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBViewController.h"

@protocol TBContainerViewControllerDelegate <TBViewControllerDelegate>

@required
-(void) loadChildrenViewControllers;

@optional
-(void) preloadChildrenViewControllers;

@end

@interface TBContainerViewController : TBViewController<TBContainerViewControllerDelegate>



@end
