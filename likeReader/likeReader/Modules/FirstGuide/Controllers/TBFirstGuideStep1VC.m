//
//  TBFirstGuideStep1VC.m
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "Masonry.h"
#import "TBFirstGuideStep1VC.h"
#import "TBFirstGuideCollectionViewCell.h"

NSString *const TBStep1CellIdentifier = @"FirstGuideStep1Cell";

@implementation TBFirstGuideStep1VC

-(void)performLoadViewSequence{
    [super performLoadViewSequence];
    self.dataArray = @[@"北京市",@"上海市",@"沈阳市",@"郑州市",@"济南市",@"西安市",@"长沙市"];
}

- (void)performViewDidLoadSequence{
    [super performViewDidLoadSequence];
    
    self.titleLab.text = @"请选择学生所在的城市";
    [self.nextBtn setTitle:@"确定,下一步" forState:UIControlStateNormal];
    
}


- (void)actionNext{
    if (!_tempStr) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:_tempStr forKey:KdefaultAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.onNext) {
        self.onNext();
    }
}


@end
