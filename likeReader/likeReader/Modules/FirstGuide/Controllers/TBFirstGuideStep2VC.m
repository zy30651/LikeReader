//
//  TBFirstGuideStep2VC.m
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "TBFirstGuideStep2VC.h"
#import "TBFirstGuideCollectionViewCell.h"


NSString *const TBStep2CellIdentifier = @"FirstGuideStep2Cell";


@implementation TBFirstGuideStep2VC

-(void)performLoadViewSequence{
    [super performLoadViewSequence];
    
    self.dataArray = @[@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级",@"七年级",@"八年级",@"九年级",@"高一班",@"高二班",@"高三班"];
}
- (void)performViewDidLoadSequence{
    [super performViewDidLoadSequence];
    self.titleLab.text = @"请选择学生所在的班级";
    [self.nextBtn setTitle:@"确定" forState:UIControlStateNormal];
}

- (void)actionNext{
    if (!_tempStr) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:_tempStr forKey:KdefaultClass];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.onNext) {
        self.onNext();
    }
}

@end
