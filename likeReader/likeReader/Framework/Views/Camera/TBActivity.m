//
//  TBActivity.m
//  likeReader
//
//  Created by ZY on 16/6/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TBActivity.h"

#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]
#define ANIMATE_DURATION                        0.25f

#define CORNER_RADIUS                           5
#define SHAREBUTTON_BORDER_WIDTH                0.5f
#define SHAREBUTTON_BORDER_COLOR                [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor
#define SHAREBUTTONTITLE_FONT                   [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]

#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:53/255.00f green:53/255.00f blue:53/255.00f alpha:1]

#define SHAREBUTTON_WIDTH                       50
#define SHAREBUTTON_HEIGHT                      50
#define SHAREBUTTON_INTERVAL_WIDTH              42.5
#define SHAREBUTTON_INTERVAL_HEIGHT             35

#define SHARETITLE_WIDTH                        50
#define SHARETITLE_HEIGHT                       20
#define SHARETITLE_INTERVAL_WIDTH               42.5
#define SHARETITLE_INTERVAL_HEIGHT              SHAREBUTTON_WIDTH+SHAREBUTTON_INTERVAL_HEIGHT
#define SHARETITLE_FONT                         [UIFont fontWithName:@"Helvetica-Bold" size:14]

#define TITLE_INTERVAL_HEIGHT                   15
#define TITLE_HEIGHT                            35
#define TITLE_INTERVAL_WIDTH                    30
#define TITLE_WIDTH                             260
#define TITLE_FONT                              [UIFont fontWithName:@"Helvetica-Bold" size:10]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2

#define BUTTON_INTERVAL_HEIGHT                  20
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   40
#define BUTTON_WIDTH                            240
#define BUTTONTITLE_FONT                        [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
#define BUTTON_BORDER_WIDTH                     0.5f
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor

@interface TBActivity (){
    UILabel *titleLabel;
    UIButton *cancelButton;
    void (^onComplete)(NSInteger index);
}

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadShareButton;
@property (nonatomic,assign) BOOL isHadCancelButton;

@end


@implementation TBActivity


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Public method

- (id)initWithTitle:(NSString *)title
  cancelButtonTitle:(NSString *)cancelButtonTitle
  ShareButtonTitles:(NSArray *)shareButtonTitlesArray
   normalImagesName:(NSArray *)normalImagesNameArray
highlightImagesName:(NSArray *)highlightImagesNameArray
   shareButtonColor:(UIColor *)shareColor
{
    self = [super init];
    if (self) {
        //初始化背景视图，添加手势
        self.activityBackColor = ACTIONSHEET_BACKGROUNDCOLOR;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle shareButtonTitles:shareButtonTitlesArray withShareButtonImagesName:normalImagesNameArray highLightImage:highlightImagesNameArray shareButtonColor:(UIColor *)shareColor];
        
    }
    return self;
}

- (void)showInView:(UIView *)view onComplete:(void (^)(NSInteger index))complete
{
    onComplete = [complete copy];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}
- (UIButton *)cancelButton{
    return cancelButton;
}

#pragma mark - Praviate method
- (void)setActivityBackColor:(UIColor *)activityBackColor{
    _activityBackColor = activityBackColor;
    self.backGroundView.backgroundColor = _activityBackColor;
}
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    titleLabel.textColor = titleColor;
}
- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle shareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray highLightImage:(NSArray *)hightlightImages shareButtonColor:(UIColor *)shareColor
{
    //初始化
    self.isHadTitle = NO;
    self.isHadShareButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.LXActivityHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backGroundView.backgroundColor = self.activityBackColor;
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    if (title) {
        self.isHadTitle = YES;
        titleLabel = [self creatTitleLabelWith:title];
        self.LXActivityHeight = self.LXActivityHeight + 2*TITLE_INTERVAL_HEIGHT+TITLE_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }
    
    if (shareButtonImagesNameArray) {
        if (shareButtonImagesNameArray.count > 0) {
            self.isHadShareButton = YES;
            for (int i = 1; i < shareButtonImagesNameArray.count+1; i++) {
                //计算出行数，与列数
                int column = (int)ceil((float)(i)/3); //行
                int line = (i)%3; //列
                if (line == 0) {
                    line = 3;
                }
                UIButton *shareButton = [self creatShareButtonWithColumn:column andLine:line];
                shareButton.tag = self.postionIndexNumber;
                [shareButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
                
                [shareButton setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndex:i-1]] forState:UIControlStateNormal];
                if (hightlightImages.count > 1) {
                    [shareButton setBackgroundImage:[UIImage imageNamed:[hightlightImages objectAtIndex:i-1]] forState:UIControlStateHighlighted];
                }
                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((line-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), self.LXActivityHeight+((column-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                }
                else{
                    [shareButton setFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((line-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), SHAREBUTTON_INTERVAL_HEIGHT+((column-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
                }
                [self.backGroundView addSubview:shareButton];
                
                self.postionIndexNumber++;
            }
        }
    }
    
    if (shareButtonTitlesArray) {
        if (shareButtonTitlesArray.count > 0 && shareButtonImagesNameArray.count > 0) {
            for (int j = 1; j < shareButtonTitlesArray.count+1; j++) {
                //计算出行数，与列数
                int column = (int)ceil((float)(j)/3); //行
                int line = (j)%3; //列
                if (line == 0) {
                    line = 3;
                }
                UILabel *shareLabel = [self creatShareLabelWithColumn:column andLine:line];
                shareLabel.text = [shareButtonTitlesArray objectAtIndex:j-1];
                shareLabel.textColor = shareColor;
                shareLabel.backgroundColor = [UIColor clearColor];
                //有Title的时候
                if (self.isHadTitle == YES) {
                    [shareLabel setFrame:CGRectMake(SHARETITLE_INTERVAL_WIDTH+((line-1)*(SHARETITLE_INTERVAL_WIDTH+SHARETITLE_WIDTH)), self.LXActivityHeight+SHAREBUTTON_HEIGHT+((column-1)*(SHARETITLE_INTERVAL_HEIGHT)), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
                }
                [self.backGroundView addSubview:shareLabel];
            }
        }
    }
    
    //再次计算加入shareButtons后LXActivity的高度
    if (shareButtonImagesNameArray && shareButtonImagesNameArray.count > 0) {
        int totalColumns = (int)ceil((float)(shareButtonImagesNameArray.count)/3);
        if (self.isHadTitle  == YES) {
            self.LXActivityHeight = self.LXActivityHeight + totalColumns*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
        else{
            self.LXActivityHeight = SHAREBUTTON_INTERVAL_HEIGHT + totalColumns*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT);
        }
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadShareButton == NO) {
            self.LXActivityHeight = self.LXActivityHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadShareButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.LXActivityHeight, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            self.LXActivityHeight = self.LXActivityHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.LXActivityHeight, [UIScreen mainScreen].bounds.size.width, self.LXActivityHeight)];
    } completion:^(BOOL finished) {
    }];
}


- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = CORNER_RADIUS;
    
    cancelBtn.layer.borderWidth = BUTTON_BORDER_WIDTH;
    cancelBtn.layer.borderColor = BUTTON_BORDER_COLOR;
    
    UIImage *image = [UIImage imageWithColor:CANCEL_BUTTON_COLOR];
    [cancelBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = BUTTONTITLE_FONT;
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return cancelBtn;
}

- (UIButton *)creatShareButtonWithColumn:(int)column andLine:(int)line
{
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(SHAREBUTTON_INTERVAL_WIDTH+((line-1)*(SHAREBUTTON_INTERVAL_WIDTH+SHAREBUTTON_WIDTH)), SHAREBUTTON_INTERVAL_HEIGHT+((column-1)*(SHAREBUTTON_INTERVAL_HEIGHT+SHAREBUTTON_HEIGHT)), SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
    return shareButton;
}

- (UILabel *)creatShareLabelWithColumn:(int)column andLine:(int)line
{
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(SHARETITLE_INTERVAL_WIDTH+((line-1)*(SHARETITLE_INTERVAL_WIDTH+SHARETITLE_WIDTH)), SHARETITLE_INTERVAL_HEIGHT+((column-1)*(SHARETITLE_INTERVAL_HEIGHT)), SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
    
    shareLabel.backgroundColor = [UIColor clearColor];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.font = TITLE_FONT;
    shareLabel.textColor = [UIColor whiteColor];
    return shareLabel;
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_INTERVAL_WIDTH, TITLE_INTERVAL_HEIGHT, TITLE_WIDTH, TITLE_HEIGHT)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.shadowColor = [UIColor blackColor];
    titlelabel.shadowOffset = SHADOW_OFFSET;
    titlelabel.font = SHARETITLE_FONT;
    titlelabel.text = title;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}

- (void)didClickOnImageIndex:(UIButton *)button
{
    if (onComplete) {
        if (button.tag != self.postionIndexNumber-1) {
            onComplete(button.tag);
        }
        else{
            onComplete(-1);
        }
    }
    [self removeSelf];
}

- (void)tappedCancel
{
    if (onComplete)
    {
        onComplete(-1);
    }
    [self removeSelf];
}

-(void) tappedBackGroundView
{
    
}

-(void) removeSelf
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewScroll" object:nil];
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [self removeFromSuperview];
                           });
            
        }
        
    }];
}


@end
