//
//  TBFirstGuideStepBaseVC.m
//  JingHan
//
//  Created by ZY on 16/4/19.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBFirstGuideStepBaseVC.h"
#import "TBFirstGuideCollectionViewCell.h"

@interface TBFirstGuideStepBaseVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation TBFirstGuideStepBaseVC

-(void)performViewDidLoadSequence{
    [super performViewDidLoadSequence];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TBSelf(weakSelf);
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont systemFontOfSize:20.0];
    [self.view addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@120);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@50);
    }];
    
    NSInteger itemRows = self.dataArray.count % 3 == 0 ? self.dataArray.count / 3 : (self.dataArray.count / 3) + 1;
    CGFloat itemSpace = 10;
    CGFloat itemWidth = 90;
    CGFloat itemHeight = 40;
    CGFloat collectionHeight = itemHeight * itemRows + (itemRows - 1) * itemSpace;
    CGFloat collectionleft = (self.view.frame.size.width - (itemWidth * 3 + itemSpace * (3 - 1)))/2;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = itemSpace;
    layout.minimumInteritemSpacing = itemSpace;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(40);
        make.height.mas_equalTo(collectionHeight);
        make.left.mas_equalTo(collectionleft);
        make.right.mas_equalTo(-collectionleft);
    }];
    
    
    _nextBtn = [[UIButton alloc]init];
    _nextBtn.backgroundColor = [UIColor blueColor];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.clipsToBounds = YES;
    _nextBtn.alpha = 0.7;
    _nextBtn.layer.cornerRadius = 3.0;
    [_nextBtn addTarget:self action:@selector(actionNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.collectionView.mas_bottom).offset(40);
        make.left.mas_equalTo(@50);
        make.right.mas_equalTo(@-50);
        make.height.mas_equalTo(@50);
    }];
}
-(void)registerCellClasses
{
    [self.collectionView registerClass:[TBFirstGuideCollectionViewCell class] forCellWithReuseIdentifier:[TBFirstGuideCollectionViewCell cellId]];
}

#pragma mark - Action
- (void)actionNext{
    // Subclasses to implement
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //进入App后的数据源地址应该存在哪
    TBFirstGuideCollectionViewCell *cell = (TBFirstGuideCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    _tempStr = cell.label.text;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TBFirstGuideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TBFirstGuideCollectionViewCell cellId] forIndexPath:indexPath];
    
    cell.label.text = self.dataArray[indexPath.row];
    return cell;
}

@end
