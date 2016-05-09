//
//  TBCellBookList.m
//  likeReader
//
//  Created by ZY on 16/5/5.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBCellBookList.h"

@interface TBCellBookList()

@property (nonatomic, strong) UIImageView *imageViewBookCover;
@property (nonatomic, strong) UILabel *bookName;
@property (nonatomic, strong) UILabel *unreadChapterCounter;
@property (nonatomic, strong) UILabel *updateChapterTitle;

@end

static NSString * const kTBCellIdentifier = @"TBCellBookList";

@implementation TBCellBookList

+(NSString *)cellId{
    return kTBCellIdentifier;
}
-(void)initMe{
    [super initMe];
    
    self.viewSeperatorLine.hidden = YES;
    self.showSeperator = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    
//    @property (nonatomic, strong) UIImageView *imageViewBookCover;
//    @property (nonatomic, strong) UILabel *bookName;
//    @property (nonatomic, strong) UILabel *unreadChapter;
//    @property (nonatomic, strong) UILabel *updateChapter;
    _imageViewBookCover = [[UIImageView alloc]init];
    _imageViewBookCover.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageViewBookCover];
    
    _bookName = [[UILabel alloc]init];
    _bookName.backgroundColor = [UIColor clearColor];
    _bookName.textAlignment = NSTextAlignmentLeft;
    _bookName.font = [UIFont boldSystemFontOfSize:20.0];
    [self addSubview:_bookName];
    
    
    _unreadChapterCounter = [[UILabel alloc]init];
    _unreadChapterCounter.backgroundColor = [UIColor clearColor];
    _unreadChapterCounter.textAlignment = NSTextAlignmentLeft;
    _unreadChapterCounter.textColor = [UIColor grayColor];
    _unreadChapterCounter.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_unreadChapterCounter];
    
    
    _updateChapterTitle = [[UILabel alloc]init];
    _updateChapterTitle.backgroundColor = [UIColor clearColor];
    _updateChapterTitle.textAlignment = NSTextAlignmentLeft;
    _updateChapterTitle.textColor = [UIColor grayColor];
    _updateChapterTitle.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_updateChapterTitle];
    
    TBSelf(weakSelf);
    
    [_imageViewBookCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@30);
        make.top.mas_equalTo(@10);
        make.width.mas_equalTo(@32);
        make.height.mas_equalTo(@47);
    }];
    
    [_bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageViewBookCover.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.imageViewBookCover.mas_top).offset(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
    }];
    
    [_unreadChapterCounter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bookName.mas_left);
        make.top.mas_equalTo(weakSelf.bookName.mas_bottom).offset(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
    }];
    
    [_updateChapterTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bookName.mas_left);
        make.top.mas_equalTo(weakSelf.unreadChapterCounter.mas_bottom).offset(10);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
    }];
}

- (void) bind:(NSString *)book{
    
}


@end
