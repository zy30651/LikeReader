//
//  TBCellDecorator.m
//  likeReader
//
//  Created by ZY on 16/5/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBCellDecorator.h"

@implementation TBCellDecorator


-(instancetype) initWithCell:(UITableViewCell*)cell
{
    self = [super init];
    if (self)
    {
        _cell = cell;
    }
    return self;
}

@end
