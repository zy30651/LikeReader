//
//  TBViewController.m
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//
#import "MBProgressHUD.h"
#import "TBViewController.h"

@interface TBViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD __weak *_hud;
    BOOL _isShown;
}
@property (nonatomic, assign) BOOL needToReloadView;

@end

@implementation TBViewController

#pragma mark - UIViewController LifeCycle
- (void)loadView{
    [super loadView];
    [self performLoadViewSequence];
    [self initFetchedResultsControllers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appearanceCount = 0;
    _timeLastDataRefresh = nil;
    
    [self setUpNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self performViewDidLoadSequence];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self performViewWillAppearSequence];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self performViewDidAppearSequence];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
-(void) setUpNavigationBar
{
    if ([self.navigationController.viewControllers objectAtIndex:0] != self)
    {
        self.navigationItem.leftBarButtonItem = [TBUtils barButtonWithImage:[UIImage imageNamed:@"frame_navi_back_button"]
                                                                 withTarget:self
                                                                     andSel:@selector(actionBack:)];
    }
    if (AtLeastIOS7)
    {
        NSDictionary* dicAttr = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [self.navigationController.navigationBar setTitleTextAttributes:dicAttr];
    }
    else
    {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:188/255.0 green:7/255.0 blue:17/255.0 alpha:1.0];
    [self initNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    TBLog(@"内存警告：Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
}


-(void) initNavigationBar
{
    // Subclasses to implement
}

#pragma mark - data operation
-(void) initFetchedResultsControllers
{
    // Subclasses to implement
}

-(BOOL) shouldRefreshData
{
    return YES;
}

-(void) refreshData
{
    // Subclasses to implement
}

#pragma mark - view loading operations

-(void) performLoadViewSequence
{
    // Subclasses to implement
}

-(void) performViewDidLoadSequence
{
    // Subclasses to implement
}

-(void) performViewWillAppearSequence
{
    [self _refreshData];
    [self _reloadView];
}

-(void) performViewDidAppearSequence
{
    // Subclasses to implement
}
-(BOOL) shouldReloadView
{
    return self.needToReloadView;
}

-(void) reloadEmptyView
{
    // Subclasses to implement
}
-(void) _refreshData
{
    if ([self shouldRefreshData])
    {
        [self refreshData];
    }
}
-(void) _reloadView
{
    if ([self shouldReloadView])
    {
        [self reloadView];
        self.needToReloadView = NO;
    }
}
#pragma mark - empty view
-(BOOL) dataEmpty
{
    NSInteger dataCount = [self.controller.fetchedObjects count];
    return (0 == dataCount);
}

#pragma mark - actions
-(void) actionBack:(id) sender
{
    // Subclasses to override
    [self.view endEditing:YES];
    
    if (self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate implementation
-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    self.needToReloadView = YES;
    [self reloadView];
}

#pragma mark - MBProgress HUD
-(void) hudWasHidden:(MBProgressHUD *)hud
{
    _hud = nil;
}

-(void) _hideHUDDelay
{
    if (_hud && _isShown && _hud.mode == MBProgressHUDModeIndeterminate)
    {
        [self MBProgressHUDPopUpMessage:@"失败" withTimeInterval:2.0];
    }
}

-(void) hideHUDDelay
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_hideHUDDelay) object:nil];
    [self performSelector:@selector(_hideHUDDelay) withObject:nil afterDelay:31];
}

-(void) MBProgressHUDPopUpMessage:(NSString *)message withTimeInterval:(NSTimeInterval)delay
{
    if (!message || message.length==0 || !_isShown)
    {
        if ((!message || message.length==0) && _hud)
        {
            [self MBProgressHUDHidePopup:YES];
        }
        return;
    }
    
    if (!_hud)
    {
        if (self.navigationController)
        {
            _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        }
        else
        {
            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
        _hud.dimBackground = YES;
    }
    _hud.delegate = self;
    _hud.mode = MBProgressHUDModeText;
    _hud.labelText = nil;
    _hud.detailsLabelText = message;
    _hud.margin = 30.f;
    _hud.removeFromSuperViewOnHide = YES;
    
    [_hud hide:YES afterDelay:delay];
}

-(void) MBProgressHUDPopUpWaitingMessage:(NSString *)message
{
    if (!_isShown)
    {
        return;
    }
    if (!_hud)
    {
        if (self.navigationController)
        {
            _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        }
        else
        {
            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
        _hud.dimBackground = YES;
    }
    
    _hud.delegate = self;
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = message;
    _hud.detailsLabelText = nil;
    _hud.margin = 20.f;
    _hud.removeFromSuperViewOnHide = YES;
    [self hideHUDDelay];
}

-(void) MBProgressHUDUpdateWaitingMessage:(NSString *)message
{
    if (!_isShown)
    {
        return;
    }
    if (_hud)
    {
        _hud.labelText = message;
        _hud.detailsLabelText = nil;
    }
}

-(void) MBProgressHUDHidePopup:(BOOL)animated withMessage:(NSString *)message afterDelay:(NSTimeInterval)delay
{
    if (!_isShown)
    {
        return;
    }
    if (_hud)
    {
        [self MBProgressHUDUpdateWaitingMessage:message];
        [_hud hide:animated afterDelay:delay];
    }
}

-(void) MBProgressHUDHidePopup:(BOOL)animated
{
    [_hud hide:animated];
}

#pragma mark - auxilliary methods
-(CGFloat) bottomBarHeight
{
    CGFloat bottomBarHeight = 0.0;
    if ([self.navigationController.viewControllers objectAtIndex:0] == self)
    {
        bottomBarHeight = self.tabBarController.tabBar.height;
    }
    return bottomBarHeight;
}

@end
