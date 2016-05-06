//
//  TBCell.m
//  likeReader
//
//  Created by ZY on 16/5/5.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBCell.h"


@interface TBCell()
{
    BOOL _bInited;
}
@end

static const CGFloat kHeight = 36.0;
static const CGFloat kLeftMargin = 21.0;
static const CGFloat kTopMargin = 0.0;
static const CGFloat kSeperatorLineHeight = 0.5;

static NSString* const kCellId = @"TBCell";

NSString* const kTBCellDecoratorCheckBox = @" kTBCellDecoratorCheckBox";

@implementation TBCell

+(NSString*) cellId
{
    return kCellId;
}
+(CGFloat) defaultHeight
{
    return kHeight;
}
+(CGFloat) heightForContent:(id)content
{
    return [TBCell defaultHeight];
}
-(CGFloat) heightForContent:(id)content
{
    return [[self class] heightForContent:content];
}
-(CGFloat) leftMargin
{
    return kLeftMargin;
}
-(CGFloat) topMargin
{
    return kTopMargin;
}
-(UIColor*) seperatorLineColor
{
    return UIColorFromRGB_hex(0xe0e0e0);
}
-(CGFloat) seperatorLineHeight
{
    return kSeperatorLineHeight;
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!_bInited)
        {
            self.showSeperatorForLastItem = NO;
            self.showSeperator = YES;
            [self initMe];
        }
        _bInited = YES;
    }
    return self;
}

// Insert your own implementation here
-(void) initMe
{
    CGFloat y = [self heightForContent:nil] - kSeperatorLineHeight;
    CGFloat h = [self seperatorLineHeight];
    UIView* viewSeperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, y, 0.0, h)];
    viewSeperatorLine.backgroundColor = [self seperatorLineColor];
    [self.contentView addSubview:viewSeperatorLine];
    _viewSeperatorLine = viewSeperatorLine;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor whiteColor];
}

-(void) prepareForReuse
{
    [super prepareForReuse];
    if (!self.decorators || 0 == [self.decorators count])
    {
        return;
    }
    NSArray* decos = [self.decorators allValues];
    
    for (id<TBCellDecorator> decorator in decos)
    {
        if (!decorator)
        {
            continue;
        }
        [decorator reset];
    }
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    [self layoutMySubviews];
}

// Insert your own implementation here
-(void) layoutMySubviews
{
    if (self.showSeperator)
    {
        CGFloat leftMargin = [self leftMargin];
        switch ([self position])
        {
            case cellFirstInSection:
            case cellMiddleInSection:
            {
                _viewSeperatorLine.hidden = NO;
                _viewSeperatorLine.left = leftMargin;
                _viewSeperatorLine.bottom = self.contentView.height;
                _viewSeperatorLine.width = self.contentView.width - leftMargin;
                break;
            }
            case cellLastInSection:
            default:
            {
                if (self.showSeperatorForLastItem)
                {
                    _viewSeperatorLine.hidden = NO;
                    _viewSeperatorLine.left = 0.0;
                    _viewSeperatorLine.bottom = self.contentView.height;
                    _viewSeperatorLine.width = self.width;//self.contentView.width;
                }
                else
                {
                    _viewSeperatorLine.hidden = YES;
                }
                break;
            }
        }
    }
    if (!self.decorators || 0 == [self.decorators count])
    {
        return;
    }
    NSArray* decos = [self.decorators allValues];
    
    for (id<TBCellDecorator> decorator in decos)
    {
        if (!decorator)
        {
            continue;
        }
        [decorator apply];
    }
}

-(void)setDecorator:(id<TBCellDecorator>)deco
            forType:(NSString *)key
{
    if (!_decorators)
    {
        _decorators = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    [self.decorators setObject:deco forKey:key];
}

-(id<TBCellDecorator>) decoratorByType:(NSString*)key
{
    if (!self.decorators)
    {
        return nil;
    }
    id<TBCellDecorator> deco = [self.decorators objectForKey:key];
    return deco;
}

@end
