//
//  TBViewController.h
//  JingHan
//
//  Created by ZY on 16/4/14.
//  Copyright © 2016年 AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol TBViewControllerDelegate <NSObject>

@optional
-(void) refreshData;

-(void) reloadView;
/**
 * This method is called in LoadView
 */
-(void) initFetchedResultsControllers;
/**
 * This method is called in viewDidLoad
 */
-(void) initNavigationBar;
/**
 * This method is called by from loadView right before
 * initFetchedResultsController is invoked. Subclass
 * should insert customization code for loadView if
 * necessary
 */
-(void) performLoadViewSequence;
/**
 * This method is called at the end (before deciding if
 * an empty view should be displayed, which is the last
 * thing viewDidLoad does). Subclass should insert
 * customization code for loadView if necessary
 *
 * viewDidLoad resets _appearanceCount, _timeLastDataRefresh;
 * sets up background; sets up navigation bar (initNavigationBar
 * is invoked before invoking this method
 */
-(void) performViewDidLoadSequence;

-(void) performViewWillAppearSequence;
/**
 * This method is called at the end of viewDidAppear.
 * _appearanceCount increased and _isShown set to YES
 * before calling this method.
 */
-(void) performViewDidAppearSequence;


-(void) actionBack:(id)sender;

@end

@interface TBViewController : UIViewController<TBViewControllerDelegate>
{
    NSDate* _timeLastDataRefresh;
    NSInteger _appearanceCount;
    UIView* /*__weak*/ _viewForEmptyContent;
}

@property (nonatomic, strong) NSFetchedResultsController* controller;
@property (nonatomic, assign) BOOL mustRefreshUponReAppear;

-(void) initNavigationBar;

-(BOOL) dataEmpty;

-(BOOL) shouldRefreshData;
-(BOOL) shouldReloadView;

/** Pop Message wait delay second */
-(void) MBProgressHUDPopUpMessage:(NSString *)message withTimeInterval:(NSTimeInterval)delay;
/** Pop Message waiting...end call "MBProgressHUDHidePopup" or 31second send error */
-(void) MBProgressHUDPopUpWaitingMessage:(NSString *)message;
/** Update Message */
-(void) MBProgressHUDUpdateWaitingMessage:(NSString *)message;
/** Update Message And Hide HUD after delay second */
-(void) MBProgressHUDHidePopup:(BOOL)animated withMessage:(NSString *)message afterDelay:(NSTimeInterval)delay;
/** Hide HUD */
-(void) MBProgressHUDHidePopup:(BOOL)animated;



-(CGFloat) bottomBarHeight;
@end
