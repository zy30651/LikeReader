//
//  TBCameraActivity.m
//  likeReader
//
//  Created by ZY on 16/6/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBCameraActivity.h"

@implementation TBCameraActivity


- (id)initCameraActivityView
{
    NSArray* iconsNormal = @[@"拍照", @"图片"];
    NSArray* iconSlect = @[@"拍照－点击", @"图片－点击"];
    NSArray* targetTitles  = @[@"照相", @"相册"];
    NSString* cancelTitle = NSLocalizedString(@"general_cancel", @"取消");
    
    
    self = [super initWithTitle:nil
              cancelButtonTitle:cancelTitle
              ShareButtonTitles:targetTitles
               normalImagesName:iconsNormal
            highlightImagesName:iconSlect
               shareButtonColor:[UIColor blackColor]];
    if (self)
    {
        self.activityBackColor = UIColorFromRGB_dec(235, 235, 235);
        UIButton* cancelButton = [self cancelButton];
        [cancelButton setBackgroundImage:nil forState:UIControlStateNormal];
        [cancelButton setTitleColor:UIColorFromRGB_dec(41, 139, 234) forState:UIControlStateNormal];
        cancelButton.layer.borderWidth = 0;
        cancelButton.top += 10;
    }
    return self;
}


@end
