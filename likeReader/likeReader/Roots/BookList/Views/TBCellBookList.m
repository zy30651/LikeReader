//
//  TBCellBookList.m
//  likeReader
//
//  Created by ZY on 16/5/5.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBCellBookList.h"

@interface TBCellBookList()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imageViewBookCover;//小说封面
@property (nonatomic, strong) UILabel *bookName;//小说名字
@property (nonatomic, strong) UILabel *readChapterTitle;//已读的章节名字、第几章
@property (nonatomic, strong) UILabel *updateChapterTitle;//最新的章节名字、第几章

@end

static NSString * const kTBCellIdentifier = @"TBCellBookList";

@implementation TBCellBookList

+(NSString *)cellId{
    return kTBCellIdentifier;
}
-(void)initMe{
    [super initMe];
    
//    _bgView = [[UIView alloc]init];
//    _bgView
//    [self addSubview:_bgView];
    self.layer.cornerRadius = 5.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
    
    self.viewSeperatorLine.hidden = YES;
    self.showSeperator = NO;
    self.backgroundColor = [UIColor whiteColor];
    
    _imageViewBookCover = [[UIImageView alloc]init];
    _imageViewBookCover.image = [UIImage imageNamed:@"bookCover"];
    _imageViewBookCover.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageViewBookCover];
    
    _bookName = [[UILabel alloc]init];
    _bookName.backgroundColor = [UIColor clearColor];
    _bookName.textAlignment = NSTextAlignmentLeft;
    _bookName.font = [UIFont boldSystemFontOfSize:20.0];
    _bookName.text = @"儒道至圣";
    [self addSubview:_bookName];
    
    
    _readChapterTitle = [[UILabel alloc]init];
    _readChapterTitle.backgroundColor = [UIColor clearColor];
    _readChapterTitle.textAlignment = NSTextAlignmentLeft;
    _readChapterTitle.textColor = [UIColor grayColor];
    _readChapterTitle.font = [UIFont systemFontOfSize:15.0];
    _readChapterTitle.text = @"第1章：刚开始";
    [self addSubview:_readChapterTitle];
    
    
    _updateChapterTitle = [[UILabel alloc]init];
    _updateChapterTitle.backgroundColor = [UIColor clearColor];
    _updateChapterTitle.textAlignment = NSTextAlignmentLeft;
    _updateChapterTitle.textColor = [UIColor grayColor];
    _updateChapterTitle.font = [UIFont systemFontOfSize:15.0];
    _updateChapterTitle.text = @"第1046章：再度私访";
    [self addSubview:_updateChapterTitle];
    
    TBSelf(weakSelf);
    
    [_imageViewBookCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@30);
        make.top.mas_equalTo(@10);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@75);
    }];
    
    [_bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageViewBookCover.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.imageViewBookCover.mas_top);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
    }];
    
    [_readChapterTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bookName.mas_left);
        make.top.mas_equalTo(weakSelf.bookName.mas_bottom).offset(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
    }];
    
    [_updateChapterTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bookName.mas_left);
        make.top.mas_equalTo(weakSelf.readChapterTitle.mas_bottom).offset(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
    }];
}

+(CGFloat)heightForCell{
    return 10 + 75 + 10 + 10;
}

- (void) bind:(NSString *)book{
    
}


@end
