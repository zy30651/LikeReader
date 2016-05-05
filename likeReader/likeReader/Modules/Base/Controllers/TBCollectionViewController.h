//
//  TBCollectionViewController.h
//  JingHan
//
//  Created by ZY on 16/4/15.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBViewController.h"

@protocol TBCollectionViewControllerDelegate <TBViewControllerDelegate>

@required
-(void) registerCellClasses;

@end

@interface TBCollectionViewController : TBViewController<TBCollectionViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout* collectionViewLayout;

@end
