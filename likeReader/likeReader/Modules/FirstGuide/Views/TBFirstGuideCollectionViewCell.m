//
//  TBFirstGuideCollectionViewCell.m
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//

#import "TBFirstGuideCollectionViewCell.h"
@interface TBFirstGuideCollectionViewCell ()
{
    UIImageView *_bgImage;
}
@end

static NSString* const kCellId = @"TBFirstGuideCollectionViewCell";

@implementation TBFirstGuideCollectionViewCell
+(NSString*) cellId
{
    return kCellId;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews{
    
    _bgImage = [[UIImageView alloc]initWithFrame:self.bounds];
    [_bgImage setImage:[UIImage imageNamed:@"cell_bg_single"]];
    [_bgImage setHighlightedImage:[UIImage imageNamed:@"card"]];
    [self addSubview:_bgImage];
    
    _label = [[UILabel alloc]initWithFrame:self.bounds];
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
}
@end
