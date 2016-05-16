//
//  TBFirstGuideStepBaseVC.h
//  JingHan
//
//  Created by ZY on 16/4/19.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "Masonry.h"
#import "TBViewController.h"
#import "TBCollectionViewController.h"


typedef void (^TBBlockNext)();

@interface TBFirstGuideStepBaseVC : TBCollectionViewController
{
    NSString *_tempStr;
}
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) TBBlockNext onNext;
@property (nonatomic , strong) UIButton *nextBtn;

@end
