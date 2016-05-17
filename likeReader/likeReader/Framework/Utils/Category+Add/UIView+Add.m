//
//  UIView+Add.m
//  likeReader
//
//  Created by ZY on 16/5/16.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)



-(CGFloat)inCenterX{
    return self.frame.size.width*0.5;
}

-(CGFloat)inCenterY{
    return self.frame.size.height*0.5;
}

-(CGPoint)inCenter{
    return CGPointMake(self.inCenterX, self.inCenterY);
}

- (CGFloat)b_width{
    return self.bounds.size.width;
}

- (CGFloat)b_height{
    return self.bounds.size.height;
}
- (CGFloat)b_x{
    return self.bounds.origin.x;
}
- (CGFloat)b_y{
    return self.bounds.origin.y;
}
- (void)setB_x:(CGFloat)b_x{
    self.bounds = CGRectMake(b_x, self.b_y, self.b_width, self.b_height);
}
- (void)setB_y:(CGFloat)b_y{
    self.bounds = CGRectMake(self.b_x, b_y, self.b_width, self.b_height);
}

- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if (view!=self && [view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
        if (![view isKindOfClass:[UIScrollView class]]) {
            x -= view.b_x;
        }
    }
    
    return x;
}



- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if (view!=self && [view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
        if (![view isKindOfClass:[UIScrollView class]]) {
            y -= view.b_y;
        }
    }
    return y;
}



- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGFloat)orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.height : self.width;
}

- (CGFloat)orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.width : self.height;
}

- (void)addTargetForTouch:(id)target action:(SEL)action
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:target action:action];
    [self addGestureRecognizer:singleTap];
}


-(UIImage *)captureWithSelfContent:(BOOL)bWithSelf
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
    
    // Get the snapshot
    UIImage *snapshotImage = nil;
    
#ifdef __IPHONE_7_0
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    if ([systemVersion rangeOfString:@"7"].length > 0 && !bWithSelf) {
        // 系统版本号包含 7
        // There he is! The new API method
        [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
        // Get the snapshot
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    }else{
#endif
        UIView *view = [[self.window subviews] objectAtIndex:0];
        self.hidden = !bWithSelf;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        //        CGContextTranslateCTM(context, 0, view.bounds.size.height);
        //        CGContextScaleCTM (context, 1, -1);
        CGContextClipToRect(context, [self convertRect:self.bounds toView:view]);
        [view.layer renderInContext:context];
        
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        self.hidden = NO;
#ifdef __IPHONE_7_0
    }
#endif
    
    // Be nice and clean your mess up
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

-(UIImage *)captureSelf
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
    
    // Get the snapshot
    UIImage *snapshotImage = nil;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //    CGContextScaleCTM (context, 1, -1);
    [self.layer renderInContext:context];
    
    snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Be nice and clean your mess up
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

- (UIImage*)screenshotWithOptimization:(BOOL)optimized
{
    if (optimized)
    {
        // take screenshot of the view
        if ([self isKindOfClass:NSClassFromString(@"MKMapView")])
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0)
            {
                // in iOS6, there is no problem using a non-retina screenshot in a retina display screen
                UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 1.0);
            }
            else
            {
                // if the view is a mapview in iOS5.0 and below, screenshot has to take the screen scale into consideration
                // else, the screen shot in retina display devices will be of a less detail map (note, it is not the size of the screenshot, but it is the level of detail of the screenshot
                UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
            }
        }
        else
        {
            // for performance consideration, everything else other than mapview will use a lower quality screenshot
            UIGraphicsBeginImageContext(self.frame.size);
        }
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    }
    
    
    
    if (UIGraphicsGetCurrentContext()==nil)
    {
        NSLog(@"UIGraphicsGetCurrentContext() is nil. You may have a UIView with CGRectZero");
        return nil;
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screenshot;
    }
    
}

- (UIImage*)screenshot
{
    return [self screenshotWithOptimization:YES];
}
@end
