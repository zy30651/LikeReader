//
//  TBRefreshStateHeader.m
//  TBRefresh
//
//  Created by ZY on 15/12/23.
//  Copyright © 2015年 TBRefresh. All rights reserved.
//
#import "TBRefreshStateHeader.h"

@interface TBRefreshStateHeader()
{
    /** 显示上一次刷新时间的label */
    __weak UILabel *_lastUpdatedTimeLabel;
    /** 显示刷新状态的label */
    __weak UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation TBRefreshStateHeader
#pragma mark - 懒加载
-(NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}
-(UILabel *)stateLabel
{    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label]];
    }
    return _stateLabel;
}
- (UILabel *)lastUpdatedTimeLabel
{
    if (!_lastUpdatedTimeLabel) {
        [self addSubview:_lastUpdatedTimeLabel = [UILabel label]];
    }
    return _lastUpdatedTimeLabel;
}

#pragma mark - 公共方法
-(void)setTitle:(NSString *)title forState:(TBRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    // 如果label隐藏了，就不用再处理
    if (self.lastUpdatedTimeLabel.hidden) return;
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    // 如果有block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @"今天 HH:mm";
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
    } else {
        self.lastUpdatedTimeLabel.text = @"最后更新：无记录";
    }
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化文字
    [self setTitle:TBRefreshHeaderIdleText forState:TBRefreshStateIdle];
    [self setTitle:TBRefreshHeaderPullingText forState:TBRefreshStatePulling];
    [self setTitle:TBRefreshHeaderRefreshingText forState:TBRefreshStateRefreshing];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        // 状态
        if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
    } else {
        CGFloat stateLabelH = self.height * 0.5;
        // 状态
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.left = 0;
            self.stateLabel.top = 0;
            self.stateLabel.width = self.width;
            self.stateLabel.height = stateLabelH;
        }
        
        // 更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.left = 0;
            self.lastUpdatedTimeLabel.top = stateLabelH;
            self.lastUpdatedTimeLabel.width = self.width;
            self.lastUpdatedTimeLabel.height = self.height - self.lastUpdatedTimeLabel.top;
        }
    }
}

- (void)setState:(TBRefreshState)state
{
    TBRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}
@end
