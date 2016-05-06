//
//  TBCellCheckboxDecorator.h
//  likeReader
//
//  Created by ZY on 16/5/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBCellDecorator.h"
typedef enum
{
    checkBoxStyleDoNotShow = 0,
    checkBoxStyleNotSelected = 1,
    checkBoxStyleSelected = 2,
    checkBoxStyleSelAndNotAllowDeselect = 3
} TBCellCheckboxStyle;


@interface TBCellCheckboxDecorator : TBCellDecorator<TBCellDecorator>

@property (nonatomic, assign) TBCellCheckboxStyle checkboxStyle;
@property (nonatomic, assign) CGFloat cellAbsoluteLeft;

@end
