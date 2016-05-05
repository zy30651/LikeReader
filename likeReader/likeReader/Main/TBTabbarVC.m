//
//  TBTabbarVC.m
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "TBMeVC.h"
#import "TBBookListVC.h"
#import "TBRankListVC.h"
#import "TBSearchBookVC.h"
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
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:188/255.0 green:7/255.0 blue:17/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    NSMutableArray *array = [NSMutableArray array];
    
    TBBookListVC *bookListVC = [[TBBookListVC alloc]init];
    bookListVC.tabBarItem.title = @"书架";
    UIImage *bookListImage = [UIImage imageNamed:@"icon_shelf"];
    bookListImage = [bookListImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bookListVC.tabBarItem.image = bookListImage;

    UIImage *homeSelectImage = [UIImage imageNamed:@"icon_shelf_highlighted"];
    homeSelectImage = [homeSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bookListVC.tabBarItem.selectedImage = homeSelectImage;
    TBNavigationVC *bookListNav = [[TBNavigationVC alloc] initWithRootViewController:bookListVC];
    [array addObject:bookListNav];
    

    TBRankListVC *rankListVC = [[TBRankListVC alloc]init];
    rankListVC.tabBarItem.title = @"排行";
    UIImage *rankListImage = [UIImage imageNamed:@"icon_rank"];
    rankListImage = [rankListImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rankListVC.tabBarItem.image = rankListImage;
    
    UIImage *messageSelectImage = [UIImage imageNamed:@"icon_rank_highlighted"];
    messageSelectImage = [messageSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rankListVC.tabBarItem.selectedImage = messageSelectImage;
    TBNavigationVC *rankListNav = [[TBNavigationVC alloc] initWithRootViewController:rankListVC];
    [array addObject:rankListNav];
    
    TBSearchBookVC *searchBookVC = [[TBSearchBookVC alloc]init];
    searchBookVC.tabBarItem.title = @"搜书";
    UIImage *circleImage = [UIImage imageNamed:@"icon_search"];
    circleImage = [circleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchBookVC.tabBarItem.image = circleImage;
    
    UIImage *searchBookImage = [UIImage imageNamed:@"icon_search_highlighted"];
    searchBookImage = [searchBookImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchBookVC.tabBarItem.selectedImage = searchBookImage;
    TBNavigationVC *searchBookNav = [[TBNavigationVC alloc] initWithRootViewController:searchBookVC];
    [array addObject:searchBookNav];
    
    TBMeVC *meVC = [[TBMeVC alloc]init];
    meVC.tabBarItem.title = @"我";
    UIImage *meImage = [UIImage imageNamed:@"icon_account"];
    meImage = [meImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVC.tabBarItem.image = meImage;
    UIImage *meSelectImage = [UIImage imageNamed:@"icon_account_highlighted"];
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
