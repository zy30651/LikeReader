//
//  TBBookListVC.m
//  likeReader
//
//  Created by ZY on 16/5/5.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBBookListVC.h"

@implementation TBBookListVC

-(void)initNavigationBar{
    self.title = @"书架";
    
    self.navigationItem.rightBarButtonItem = [TBUtils barButtonWithTitle:@"管理" withTarget:self andSel:@selector(managerBooks)];
}

#pragma mark - Action
- (void)managerBooks{
    
}

@end
