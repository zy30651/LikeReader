//
// QR Code Generator - generates UIImage from NSString
//
// Copyright (C) 2012 http://moqod.com Andrew Kopanev <andrew@moqod.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal 
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
// of the Software, and to permit persons to whom the Software is furnished to do so, 
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all 
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
//

#import "QRCodeGenerator.h"
#import "qrencode.h"

enum {
	qr_margin = 3
};

@implementation QRCodeGenerator

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
	unsigned char *data = 0;
	int width;
	data = code->data;
	width = code->width;
	float zoom = (double)size / (code->width + 2.0 * qr_margin);
	CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
	
	// draw
	CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
	for(int i = 0; i < width; ++i) {
		for(int j = 0; j < width; ++j) {
			if(*data & 1) {
				rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
				CGContextAddRect(ctx, rectDraw);
			}
			++data;
		}
	}
	CGContextFillPath(ctx);
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size {
	if (![string length]) {
		return nil;
	}
	
	QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
	if (!code) {
		return nil;
	}
	
	// create context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
	
	CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
	CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
	CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
	
	// draw QR on this context	
	[QRCodeGenerator drawQRCode:code context:ctx size:size];
	
	// get image
	CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
	UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
	
	// some releases
	CGContextRelease(ctx);
	CGImageRelease(qrCGImage);
	CGColorSpaceRelease(colorSpace);
	QRcode_free(code);
	
	return qrImage;
}



#pragma mark - custom method
// 自己添加的
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight){
    float fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size withPointType:(QRPointType)pointType withPositionType:(QRPositionType)positionType withColor:(UIColor *)color logo:(UIImage *)logoImg{
	unsigned char *data = 0;
	int width;
	data = code->data;
	width = code->width;
	float zoom = (double)size / (code->width + 2.0 * qr_margin);
	CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);

    // compute logo rect
    float logow = MIN(zoom*code->width/4, MIN(logoImg.size.width, logoImg.size.height));
    float logoh = MIN(zoom*code->width/4, MIN(logoImg.size.width, logoImg.size.height));
	float logol = (size-logow)/2;
    float logot = (size-logoh)/2;
    
	// draw
    if (!color) {
        color = [UIColor blackColor];
    }
    CGFloat red,green,blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBFillColor(ctx, red, green, blue, 1.0);
    //	CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
	for(int i = 0; i < width; ++i) {
		for(int j = 0; j < width; ++j) {
			if(*data & 1) {
				rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                if (positionType == QRPositionNormal) {
                    switch (pointType) {
                        case QRPointRect:
                            CGContextAddRect(ctx, rectDraw);
                            break;
                        case QRPointRound:
                            CGContextAddEllipseInRect(ctx, rectDraw);
                            break;
                        default:
                            break;
                    }
                }else if(positionType == QRPositionRound) {
                    switch (pointType) {
                        case QRPointRect:
                            CGContextAddRect(ctx, rectDraw);
                            break;
                        case QRPointRound:
                            if ((i>=0 && i<=6 && j>=0 && j<=6) || (i>=0 && i<=6 && j>=width-7-1 && j<=width-1) || (i>=width-7-1 && i<=width-1 && j>=0 && j<=6)) {
                                CGContextAddRect(ctx, rectDraw);
                            }else {
                                CGContextAddEllipseInRect(ctx, rectDraw);
                            }
                            break;
                        default:
                            break;
                    }
                }
			}
			++data;
		}
	}
	CGContextFillPath(ctx);
    if (logoImg) {
        CGRect rect = CGRectMake(logol, logot, logow, logoh);
        CGRect rect2 = CGRectMake(logol+3, logot+3, logow-6, logoh-6);
        
        // 白色背景
        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
        CGContextBeginPath(ctx);
        addRoundedRectToPath(ctx, rect, rect.size.width/5, rect.size.width/5);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
        CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
        
        CGContextBeginPath(ctx);
        addRoundedRectToPath(ctx, rect2, rect2.size.width/5, rect2.size.width/5);
        CGContextClosePath(ctx);
        CGContextClip(ctx);
        CGContextDrawImage(ctx, rect2, logoImg.CGImage);
    }
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size withPointType:(QRPointType)pointType withPositionType:(QRPositionType)positionType withColor:(UIColor *)color logo:(UIImage *)logo{
	if (![string length]) {
		return nil;
	}
	
	QRcode *code = nil;
	if (!logo)
        code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    else
        code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_Q, QR_MODE_8, 1);
	if (!code) {
		return nil;
	}
        
	// create context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, 1);
	
	CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
	CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
	CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
	
	// draw QR on this context
	[QRCodeGenerator drawQRCode:code context:ctx size:size withPointType:pointType withPositionType:positionType withColor:color logo:logo];
	
	// get image
	CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
	UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
	
	// some releases
	CGContextRelease(ctx);
	CGImageRelease(qrCGImage);
	CGColorSpaceRelease(colorSpace);
	QRcode_free(code);
	
	return qrImage;
}

+ (UIImage*) qrImageForString:(NSString*)strQR
                     andLogo:(UIImage*)imglogo
                    andColor:(UIColor*)color{
    if (0 == strQR.length)
    {
        return nil;
    }
    UIImage *image = [QRCodeGenerator qrImageForString:strQR
                                             imageSize:[UIApplication sharedApplication].keyWindow.frame.size.width
                                         withPointType:QRPointRect
                                      withPositionType:QRPositionNormal
                                             withColor:color//UIColorFromRGB_dec(109, 149, 173)
                                                  logo:imglogo];
    UIImage* imgQR = nil;
    if (image)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        imageView.image = image;
        [view addSubview:imageView];
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), NO, 0.0);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        imgQR = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return imgQR;
}
@end
