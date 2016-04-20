//
//  TBTabbarVC.m
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "TBMeVC.h"
#import "TBHomeVC.h"
#import "TBCircleVC.h"
#import "TBCourseVC.h"
#import "TBMessageVC.h"
#import "TBTabbarVC.h"
#import "TBNavigationVC.h"

@interface TBTabbarVC ()<UINavigationControllerDelegate>

@end

static TBTabbarVC* g_tabBarController = nil;

@implementation TBTabbarVC

#pragma mark - get self instance and setup self
+(TBTabbarVC*) tabBarController
{
    if (nil == g_tabBarController)
    {
        g_tabBarController = [TBTabbarVC setupTabBarController];
    }
    return g_tabBarController;
}


+(TBTabbarVC*) setupTabBarController
{
    NSMutableArray *array = [NSMutableArray array];
    
    TBHomeVC *homeVC = [[TBHomeVC alloc]init];
    homeVC.tabBarItem.title = @"首页";
    UIImage *homeImage = [UIImage imageNamed:@"tb_teacher_normal"];
    homeImage = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.image = homeImage;

    UIImage *homeSelectImage = [UIImage imageNamed:@"tb_teacher_select"];
    homeSelectImage = [homeSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = homeSelectImage;
    TBNavigationVC *homeNav = [[TBNavigationVC alloc] initWithRootViewController:homeVC];
    [array addObject:homeNav];
    

    TBMessageVC *messageVC = [[TBMessageVC alloc]init];
    homeVC.tabBarItem.title = @"消息";
    UIImage *messageImage = [UIImage imageNamed:@"tb_message_normal"];
    messageImage = [messageImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageVC.tabBarItem.image = messageImage;
    
    UIImage *messageSelectImage = [UIImage imageNamed:@"tb_message_select"];
    messageSelectImage = [messageSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageVC.tabBarItem.selectedImage = messageSelectImage;
    TBNavigationVC *messageNav = [[TBNavigationVC alloc] initWithRootViewController:messageVC];
    [array addObject:messageNav];
    
    TBCircleVC *circleVC = [[TBCircleVC alloc]init];
    circleVC.tabBarItem.title = @"圈子";
    UIImage *circleImage = [UIImage imageNamed:@"tb_teacher_normal"];
    circleImage = [circleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    circleVC.tabBarItem.image = circleImage;
    
    UIImage *circleSelectImage = [UIImage imageNamed:@"tb_teacher_select"];
    circleSelectImage = [circleSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    circleVC.tabBarItem.selectedImage = circleSelectImage;
    TBNavigationVC *circleNav = [[TBNavigationVC alloc] initWithRootViewController:circleVC];
    [array addObject:circleNav];
    
    
    TBCourseVC *courseVC = [[TBCourseVC alloc]init];
    courseVC.tabBarItem.title = @"课程";
    UIImage *courseImage = [UIImage imageNamed:@"tb_class_normal"];
    courseImage = [courseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    courseVC.tabBarItem.image = courseImage;
    UIImage *courseSelectImage = [UIImage imageNamed:@"tb_class_select"];
    courseSelectImage = [courseSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    courseVC.tabBarItem.selectedImage = courseSelectImage;
    TBNavigationVC *courseNav = [[TBNavigationVC alloc] initWithRootViewController:courseVC];
    [array addObject:courseNav];
    
    TBMeVC *meVC = [[TBMeVC alloc]init];
    meVC.tabBarItem.title = @"我";
    UIImage *meImage = [UIImage imageNamed:@"tb_me_normal"];
    meImage = [meImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVC.tabBarItem.image = meImage;
    UIImage *meSelectImage = [UIImage imageNamed:@"tb_me_select"];
    meSelectImage = [meSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVC.tabBarItem.selectedImage = meSelectImage;
    TBNavigationVC *meNav = [[TBNavigationVC alloc] initWithRootViewController:meVC];
    [array addObject:meNav];
    
    TBTabbarVC *tab = [[TBTabbarVC alloc] initWithVCs:array];
    
    return tab;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        if (1) {NSLog(@"\nRunning %@ '%@'",self.class,NSStringFromSelector(_cmd));}
        [self addNotifications];
    }
    return self;
}

- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onLogoutNotification:) name:kLogoutNotification object:nil];
}

-(instancetype) initWithVCs:(NSArray*)viewControllers
{
    self = [self init];
    if (self)
    {
        self.viewControllers = viewControllers;
        UINavigationController* nav = nil;
        for (UIViewController* vc in viewControllers)
        {
            if (!vc || ![vc isKindOfClass:[UINavigationController class]])
            {
                continue;
            }
            nav = (UINavigationController*)vc;
            nav.delegate = self;
        }
    }
    return self;
}

#pragma mark - handle token expiration and logout
- (void)onLogoutNotification:(NSNotification*) notification
{
    //如果用户登录该怎么做
}


-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLogoutNotification object:nil];
}

@end
