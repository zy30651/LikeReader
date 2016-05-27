//
//  TBPhotoGroupView.h
//  likeReader
//
//  Created by ZY on 16/5/26.
//  Copyright © 2016年 jack. All rights reserved.
//
//
//UIImageView *fromView = nil;
//NSMutableArray *items = [NSMutableArray new];
//NSArray *images = cell.layout.images;
//
//for (NSUInteger i = 0, max = images.count; i < max; i++) {
//    UIImageView *imgView = cell.statusView.mediaView.imageViews[i];
//    T1Media *img = images[i];
//    YYPhotoGroupItem *item = [YYPhotoGroupItem new];
//    item.thumbView = imgView;
//    item.largeImageURL = img.mediaLarge.url;
//    item.largeImageSize = z;
//    [items addObject:item];
//    if (i == index) {
//        fromView = imgView;
//    }
//}
//YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
//[v presentFromImageView:fromView toContainer:self.navigationController.view animated:YES completion:nil];
//
//
//
//
//
//

#import <UIKit/UIKit.h>

/// Single picture's info.
@interface TBPhotoGroupItem : NSObject
@property (nonatomic, strong) UIView *thumbView; ///< thumb image, used for animation position calculation
@property (nonatomic, assign) CGSize largeImageSize;
@property (nonatomic, strong) NSURL *largeImageURL;
@end


/// Used to show a group of images.
/// One-shot.
@interface TBPhotoGroupView : UIView
@property (nonatomic, readonly) NSArray *groupItems; ///< Array<TBPhotoGroupItem>
@property (nonatomic, readonly) NSInteger currentPage;
@property (nonatomic, assign) BOOL blurEffectBackground; ///< Default is YES


- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithGroupItems:(NSArray *)groupItems;

- (void)presentFromImageView:(UIView *)fromView
                 toContainer:(UIView *)container
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;

@end
