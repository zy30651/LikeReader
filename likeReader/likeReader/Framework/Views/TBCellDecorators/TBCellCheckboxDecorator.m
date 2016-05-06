//
//  TBCellCheckboxDecorator.m
//  likeReader
//
//  Created by ZY on 16/5/6.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBCellCheckboxDecorator.h"
#import "TBCell.h"

@interface TBCellCheckboxDecorator ()
{
    UIImageView* _imageViewChkBox;
}

@end

static UIImage* imageCheckBoxNotSel = nil;
static UIImage* imageCheckBoxSel = nil;
static UIImage* imageCheckBoxSelNotAllowDeselect = nil;

@implementation TBCellCheckboxDecorator
+(UIImage*) imageCheckBoxNotSel
{
    if (!imageCheckBoxNotSel)
    {
        imageCheckBoxNotSel = [UIImage imageNamed:@"checkMark_blue_circle_unchecked"];
    }
    return imageCheckBoxNotSel;
}

+(UIImage*) imageCheckBoxSel
{
    if (!imageCheckBoxSel)
    {
        imageCheckBoxSel = [UIImage imageNamed:@"checkMark_blue_circle_checked"];
    }
    return imageCheckBoxSel;
}

+(UIImage*) imageCheckBoxSelNotAllowDeselect
{
    if (!imageCheckBoxSelNotAllowDeselect)
    {
        imageCheckBoxSelNotAllowDeselect = [UIImage imageNamed:@"checkbok_can_not_click"];
    }
    return imageCheckBoxSelNotAllowDeselect;
}
//Undefined symbols for architecture x86_64:
//"_kTBCellDecoratorCheckBox", referenced from:
//-[TBCellCheckboxDecorator initWithCell:] in TBCellCheckboxDecorator.o
//ld: symbol(s) not found for architecture x86_64
//clang: error: linker command failed with exit code 1 (use -v to see invocation)
-(instancetype) initWithCell:(TBCell*)cell
{
    self = [super initWithCell:cell];
    if (self)
    {
        _imageViewChkBox = nil;
        _cellAbsoluteLeft = 0.0;
        [cell setDecorator:self forType:kTBCellDecoratorCheckBox];
    }
    return self;
}

-(void) initImageViewChkBox
{
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[TBCellCheckboxDecorator imageCheckBoxNotSel]];
    _imageViewChkBox = imageView;
}

-(void) setCheckboxStyle:(TBCellCheckboxStyle)checkboxStyle
{
    _checkboxStyle = checkboxStyle;
    if (checkBoxStyleDoNotShow == self.checkboxStyle)
    {
        _imageViewChkBox = nil;
        return;
    }
    
    if (!_imageViewChkBox)
    {
        [self initImageViewChkBox];
    }
    switch (self.checkboxStyle)
    {
        case checkBoxStyleNotSelected:
        {
            _imageViewChkBox.image = [TBCellCheckboxDecorator imageCheckBoxNotSel];
            break;
        }
        case checkBoxStyleSelected:
        {
            _imageViewChkBox.image = [TBCellCheckboxDecorator imageCheckBoxSel];
            break;
        }
        case checkBoxStyleSelAndNotAllowDeselect:
        {
            _imageViewChkBox.image = [TBCellCheckboxDecorator imageCheckBoxSelNotAllowDeselect];
            break;
        }
        default:
            break;
    }
}

-(void) reset
{
    if (!self.cell)
    {
        return;
    }
    _checkboxStyle = checkBoxStyleDoNotShow;
    if (self.cell.accessoryView == _imageViewChkBox)
    {
        self.cell.accessoryView = nil;
    }
    else if (_imageViewChkBox)
    {
        [_imageViewChkBox removeFromSuperview];
        self.cell.accessoryView = nil;
    }
    _imageViewChkBox = nil;
}

-(void) apply
{
    if (!self.cell || !_imageViewChkBox)
    {
        return;
    }
    self.cell.accessoryView = _imageViewChkBox;
}
@end
