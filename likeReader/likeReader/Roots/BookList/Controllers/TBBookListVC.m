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
    
    // 字符串
    NSString *str = @"日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。";
    
    // 初始化label
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
}

-(void)registerCellClasses{
    [self.tableView registerClass:[TBCellBookList class] forCellReuseIdentifier:[TBCellBookList cellId]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TBCellBookList *cell = [tableView dequeueReusableCellWithIdentifier:[TBCellBookList cellId]];
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
