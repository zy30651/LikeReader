//
//  TBCalendarCell.m
//  Framework
//
//  Created by ZY on 16/4/11.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBCalendarCell.h"

@implementation TBCalendarCell
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}
@end
