//
//  TBCalendarView.m
//  Framework
//
//  Created by ZY on 16/4/11.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "Masonry.h"
#import "TBCalendarCell.h"
#import "TBCalendarView.h"

@interface TBCalendarView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UILabel *monthLabel;
@property (nonatomic , strong) UIButton *previousBtn;
@property (nonatomic , strong) UIButton *nextBtn;
/** 表头---一、二、三、四、五、六、日；MON、TUE、WED、THU、FRI、SAT、SUN等等 */
@property (nonatomic , strong) NSArray *weekDayArray;

@end

NSString *const TBCalendarCellIdentifier = @"cell";

@implementation TBCalendarView

- (NSArray *)weekDayArray{
    if (_weekDayArray == nil) {
        _weekDayArray = @[@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"SUN"];
    }
    return  _weekDayArray;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews{
    
    __weak __typeof(&*self) weakSelf = self;
    
    //上个月Btn---月份Lab---下个月按钮
    //CollectionView
    self.backgroundColor = [UIColor grayColor];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = UIColorFromRGB_hex(0x20c48a);
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@44);
    }];
    
    _previousBtn = [[UIButton alloc]init];
    _previousBtn.clipsToBounds = YES;
    _previousBtn.backgroundColor = [UIColor clearColor];
    [_previousBtn setImage:[UIImage imageNamed:@"bt_previous"] forState:UIControlStateNormal];
    [_previousBtn sizeToFit];
    [_previousBtn addTarget:self action:@selector(actionPreviousBtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_previousBtn];
    [_previousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(@44);
    }];
    
    
    _nextBtn = [[UIButton alloc]init];
    _nextBtn.clipsToBounds = YES;
    _nextBtn.backgroundColor = [UIColor clearColor];
    [_nextBtn setImage:[UIImage imageNamed:@"bt_next"] forState:UIControlStateNormal];
    [_nextBtn sizeToFit];
    [_nextBtn addTarget:self action:@selector(actionNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.width.mas_equalTo(@44);
    }];
    
    _monthLabel = [[UILabel alloc]init];
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_monthLabel];
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.left.mas_equalTo(weakSelf.previousBtn.mas_right);
        make.right.mas_equalTo(weakSelf.nextBtn.mas_left);
    }];
    
    CGFloat itemWidth = self.frame.size.width / 7;
    CGFloat itemHeight = (self.frame.size.height - 44) / 7;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
    }];

    [_collectionView registerClass:[TBCalendarCell class] forCellWithReuseIdentifier:TBCalendarCellIdentifier];
    [self addSwipe];
}
#pragma mark - Date
-(void)setDate:(NSDate *)date{
    _date = date;
    //重新设置月份--并刷新collectionView数据
    [_monthLabel setText:[NSString stringWithFormat:@"%.2ld-%li",(long)[self month:date],(long)[self year:date]]];
    [_collectionView reloadData];
}

- (NSInteger)day:(NSDate *)date{
    return  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:date];
}

- (NSInteger)month:(NSDate *)date{
    return  [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:date];
}
- (NSInteger)year:(NSDate *)date{
    return  [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:date];
}

- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calenday = [NSCalendar currentCalendar];
    [calenday setFirstWeekday:1];//Sun
    NSDateComponents *comp = [calenday components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)  fromDate:date];
    [comp setDay:1];
    
    NSDate *firstDayOfMonthDate = [calenday dateFromComponents:comp];
    NSUInteger firstWeekDay = [calenday ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitMonth forDate:firstDayOfMonthDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
    return firstWeekDay - 1;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return  totaldaysInMonth.length;
}

- (NSDate *)preMonth:(NSDate *)date{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.month = -1;
    NSDate *preDate = [[NSCalendar currentCalendar]dateByAddingComponents:comp toDate:date options:0];
    return  preDate;
}
- (NSDate *)nextMonth:(NSDate *)date{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:comp toDate:date options:0];
    return  newDate;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return  self.weekDayArray.count;
    }else{
        return 42;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TBCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TBCalendarCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell.dateLabel setFont:[UIFont systemFontOfSize:12.0]];
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:UIColorFromRGB_hex(0x15cc9c)];
    }else{
//        NSInteger red = arc4random() % 256;
//        NSInteger green = arc4random() % 255;
//        NSInteger blue = arc4random() % 254;
//        cell.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
        
        [cell.dateLabel setFont:[UIFont systemFontOfSize:20.0]];
        //1:首先确认当前月份的日数
        NSInteger daysInMonth = [self totaldaysInMonth:_date];
        //2:确认第一周有几个空白天.即这个月的第一天从这周的第几天开始
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        //3:如果小于这个数字，Item为@”“，如果大于这个数字和当月天数的 总和 也为@”“
        if (i < firstWeekday) {//如果4月1日是周五,i < 1号所在的Item
            [cell.dateLabel setText:@""];
        }else if (i > firstWeekday + daysInMonth - 1){//如果4月30号是周3， i > 30号所在的Item
            [cell.dateLabel setText:@""];
        }else{//当月的天数
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%ld",day]];
            [cell.dateLabel setTextColor:UIColorFromRGB_hex(0x6f6f6f)];

            //4:最后就是过去、现在、未来的月份的某些天的字体颜色了
            if ([_today isEqualToDate:_date]) {//当月
                if (day == [self day:_date]) {//当天
                    [cell.dateLabel setTextColor:UIColorFromRGB_hex(0x4898eb)];
                }else if(day > [self day:_date]){//当月的未来几天
                    [cell.dateLabel setTextColor:UIColorFromRGB_hex(0xcbcbcb)];
                }
            }else if([_today compare:_date] == NSOrderedAscending){//未来
                [cell.dateLabel setTextColor:UIColorFromRGB_hex(0xcbcbcb)];
            }
        }
    }
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            return YES;
        }
    }
    return NO;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    if (self.calendarBlock) {
        self.calendarBlock(day,[comp month],[comp year]);
    }
}

#pragma mark - Action
- (void)actionPreviousBtn{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.date = [self preMonth:_date];
    } completion:nil];
}
- (void)actionNextBtn{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.date = [self nextMonth:_date];
    } completion:nil];
}

- (void)addSwipe
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionNextBtn)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionNextBtn)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionPreviousBtn)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(actionPreviousBtn)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
}
@end
