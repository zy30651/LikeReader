//
//  TBBookListVC.m
//  likeReader
//
//  Created by ZY on 16/5/5.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBBookListVC.h"
#import "TBCellBookList.h"
#import "TBShowHUD.h"

@implementation TBBookListVC

-(void)initNavigationBar{
    self.title = @"书架";
    
    self.navigationItem.rightBarButtonItem = [TBUtils barButtonWithTitle:@"管理" withTarget:self andSel:@selector(managerBooks)];
}
-(void)performViewDidLoadSequence{
    [super performViewDidLoadSequence];
    self.tableView.top = 10;
    self.tableView.backgroundColor = [UIColor grayColor];
}
-(void)registerCellClasses{
    [self.tableView registerClass:[TBCellBookList class] forCellReuseIdentifier:[TBCellBookList cellId]];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TBCellBookList heightForCell];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TBCellBookList *cell = [tableView dequeueReusableCellWithIdentifier:[TBCellBookList cellId]];
    UIView *marginView = [[UIView alloc]init];
    marginView.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:marginView];
    [cell.contentView sendSubviewToBack:marginView];
    
    return cell;
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
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
