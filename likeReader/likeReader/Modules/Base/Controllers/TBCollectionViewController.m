//
//  TBCollectionViewController.m
//  JingHan
//
//  Created by ZY on 16/4/15.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBCollectionViewController.h"

@interface TBCollectionViewController()


@end


@implementation TBCollectionViewController



-(void) performViewDidLoadSequence
{
    [self initCollectionView];
    [self registerCellClasses];
}
- (void)initCollectionView{
    if (!self.collectionViewLayout)
    {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewLayout = layout;
    }
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
}
- (void) registerCellClasses
{
    // Subclasses to implement
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // Subclasses to implement
    return  0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // Subclasses to implement
    return nil;
}
@end
