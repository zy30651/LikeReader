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
@property (nonatomic, strong) UILabel *unreadChapter;
@property (nonatomic, strong) UILabel *updateChapter;

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
}

- (void) bind:(NSString *)book{
    
}


@end
