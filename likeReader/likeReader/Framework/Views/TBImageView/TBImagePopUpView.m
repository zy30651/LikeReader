//
//  TBImagePopUpView.m
//  likeReader
//
//  Created by ZY on 16/5/25.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBImagePopUpView.h"
#import "UAProgressView.h"
#import "UIImageView+WebCache.h"

@interface TBImagePopUpView()<UIScrollViewDelegate>{
    /** 图片原始的frame */
    CGRect _parentFrame;
    
    /** 图片按原比例缩放后大小 */
    CGRect _frameRect;
}

/** 图片所在的UIView的父View,必须是UIScrollView才支持双击放大 */
@property (nonatomic, strong) UIScrollView* imageBackScrollView;
/** 图片所在UIView */
@property (nonatomic, strong)  UIImageView * photoView;
/** 半透明的背景遮罩 */
@property (nonatomic, strong)  UIView* maskView;

@end

@implementation TBImagePopUpView


- (id)initWithOriginalFrame :(CGRect)originalFrame
                defaultImage:(UIImage *)defaultImage
                 OriginalUrl:(NSURL *) originalUrl{
    self = [super initWithFrame: [UIApplication sharedApplication].keyWindow.frame];
    if (self) {
        _parentFrame = originalFrame;
        [self SetPhotoImage:defaultImage originalURL:originalUrl];
    }
    return self;
}

- (void)SetPhotoImage:(UIImage *)photoImage originalURL :(NSURL *)originalURL{
    
    UIImage * defaultImage = photoImage;
    if (_imageBackScrollView==nil&&defaultImage!=nil) {
        //设置图片显示的大小
        
        _frameRect = [self setPhotoFrame:defaultImage];
        //添加遮罩层
        _maskView = [[UIView alloc]initWithFrame:self.frame];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha=1.0;
        [self addSubview:_maskView];
        
        //添加scrollview
        _imageBackScrollView=[[UIScrollView alloc] initWithFrame:self.frame];
        _imageBackScrollView.backgroundColor=[UIColor clearColor];
        _imageBackScrollView.delegate=self;
        _imageBackScrollView.bouncesZoom=YES;
        _imageBackScrollView.contentSize=CGSizeMake(_frameRect.size.width, _frameRect.size.height);
        
        _imageBackScrollView.minimumZoomScale = 0.99;
        _imageBackScrollView.maximumZoomScale = 8.0;
        
        _imageBackScrollView.showsHorizontalScrollIndicator=NO;
        _imageBackScrollView.showsVerticalScrollIndicator=NO;
        _imageBackScrollView.scrollEnabled=YES;
        [self addSubview:_imageBackScrollView];
        
        //在scrollview添加UIImageView
        _photoView = [[UIImageView alloc]initWithFrame:_frameRect];
        _photoView.center=self.center;
        
        UAProgressView *prog = [[UAProgressView alloc]init];
        UAProgressView __weak *progressView = prog;
        progressView.center = CGPointMake(CGRectGetMidX(_photoView.bounds), CGRectGetMidY(_photoView.bounds));
        progressView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [_photoView addSubview:progressView];
        progressView.progress = 0;
        if (originalURL)
            [_photoView sd_setImageWithURL:originalURL placeholderImage:defaultImage options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                //这里没测试是否能检测到图片大小.需要测试
                CGFloat progress = (CGFloat)receivedSize / (CGFloat)expectedSize;
                [progressView setProgress:progress];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                progressView.hidden = YES;
            }];
        else{
            _photoView.image = defaultImage;
            progressView.hidden = YES;
        }
        _photoView.userInteractionEnabled = YES;
        [_imageBackScrollView addSubview:_photoView];
        
    }
}

-(void)showPopImage
{
    //图片弹出效果
    if (_photoView.image !=nil) {
        
        [self fadeIn];
        UIViewController* currentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIView* viewToAddto = currentVC.view;
        UIViewController* presentedVC = currentVC.presentedViewController;
        if (presentedVC)
        {
            viewToAddto = presentedVC.view;
        }
        [viewToAddto addSubview: self];
        
        //手势操作 点击图片关闭
        UITapGestureRecognizer *signalTapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fadeOut)];
        signalTapRecognize.numberOfTapsRequired = 1;
        [signalTapRecognize setEnabled :YES];
        [signalTapRecognize delaysTouchesBegan];
        [signalTapRecognize cancelsTouchesInView];
        _photoView.userInteractionEnabled=YES;
        [self addGestureRecognizer:signalTapRecognize];
        
        //手势操作 双击图片后放大
        UITapGestureRecognizer *doubleTapRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClickFill)];
        doubleTapRecognize.numberOfTapsRequired = 2;
        [doubleTapRecognize setEnabled: YES];
        [_photoView addGestureRecognizer:doubleTapRecognize];
        [signalTapRecognize requireGestureRecognizerToFail:doubleTapRecognize];
        
    }
}

/*
 *缩放时候重新设置图片位置
 */
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //当捏或移动时，需要对center重新定义以达到正确显示未知
    CGFloat xcenter = scrollView.center.x,ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width?scrollView.contentSize.width/2 :xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height/2 : ycenter;
    [_photoView setCenter:CGPointMake(xcenter, ycenter)];
}

/*
 *  双击图片 放大 适用于屏幕高度
 */
-(void)doubleClickFill
{
    if (_imageBackScrollView.zoomScale!= 1) {
        [UIView animateWithDuration:0.2f animations:^{
            _imageBackScrollView.zoomScale = 1;
        }];
        
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            _imageBackScrollView.zoomScale = 2;
        }];
    }
}

#pragma mark ===私有方法
//私有方法
-(CGRect)setPhotoFrame:(UIImage *)photoImage
{
    CGFloat widthImage = 0.0;
    CGFloat heightImage = 0.0;
    CGFloat rat=photoImage.size.width/photoImage.size.height;
    CGFloat ratConstant = 320.0/460.0;
    if (rat>ratConstant) {
        widthImage = 320.0;
        heightImage = widthImage/rat;
    }
    else{
        heightImage = 460.0;
        widthImage=heightImage*rat;
    }
    CGRect frameRec=CGRectMake(0,0,widthImage,heightImage);//图片显示大小
    return frameRec;
}

#pragma  mark ===图片渐入 渐出动画
/*
 * fadeIn 图片渐入动画
 */
-(void)fadeIn
{
    CGRect temp = _photoView.frame;
    _photoView.frame = _parentFrame;
    _maskView.alpha = 0.0;
    _photoView.alpha = 0.0f;
    _imageBackScrollView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.35f animations:^{
        _maskView.alpha = 1.0f;
        _photoView.alpha = 1.0f;
        _imageBackScrollView.alpha = 1.0f;
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            _imageBackScrollView.transform = CGAffineTransformMakeScale(1, 1);
            _photoView.frame = temp;
            _photoView.center = self.center;
            _imageBackScrollView.center=self.center;
        } completion:^(BOOL finished) {
        }];
    }];
}


/*
 * fadeOut 图片逐渐消失动画
 */
- (void)fadeOut
{
    if(_maskView !=nil && _photoView !=nil && _imageBackScrollView !=nil){
        _imageBackScrollView.alpha = 1.0f;
        _maskView.alpha =1.0;
        [UIView animateWithDuration:0.25 animations:^{
            [UIApplication sharedApplication].statusBarHidden = NO;
            _maskView.alpha = 0.3;
            _photoView.alpha = 0.0;
            CGRect rect = [self.window convertRect:_parentFrame toView:_imageBackScrollView];
            _photoView.frame = rect;
        } completion:^(BOOL finished) {
            _photoView.alpha = 0.0f;
            [UIApplication sharedApplication].statusBarHidden = NO;
            [UIView animateWithDuration:0.1f animations:^{
                _maskView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [_imageBackScrollView removeFromSuperview];
                [_maskView removeFromSuperview];
                _maskView=nil;
                _imageBackScrollView=nil;
                [self removeFromSuperview];
            }];
        }];
    }
}
@end
