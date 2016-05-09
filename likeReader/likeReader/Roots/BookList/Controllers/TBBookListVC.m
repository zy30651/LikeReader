//
//  TBBookListVC.m
//  likeReader
//
//  Created by ZY on 16/5/5.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBBookListVC.h"
#import "TBCellBookList.h"

@implementation TBBookListVC

-(void)initNavigationBar{
    self.title = @"书架";
    
    self.navigationItem.rightBarButtonItem = [TBUtils barButtonWithTitle:@"管理" withTarget:self andSel:@selector(managerBooks)];
}

-(void)registerCellClasses{
    [self.tableView registerClass:[TBCellBookList class] forCellReuseIdentifier:[TBCellBookList cellId]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TBCellBookList *cell = [tableView dequeueReusableCellWithIdentifier:[TBCellBookList cellId]];
    return nil;
}

#pragma mark - Action
- (void)managerBooks{
    //管理书籍
    //展示选择按钮、底部管理BarView;
    //具体：选择某一书籍后，底部BarView的按钮才可用.
    //BarView功能
    //移除书架并删除该小说;
    //下载本书--可以选择多本小说，同时下载;
    //查看详情--跳转到详情页
}

@end
