//
//  UIImage+ColorReplacement.m
//  Animation
//
//  Created by Allen on 11/22/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "UIImage+ColorReplacement.h"

@implementation UIImage (ColorReplacement)

+ (UIImage *)imageNamed:(NSString *)name replaceColor:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:name];
    UIImage *resultImage = [UIImage image:image replaceColor:color];
    
    return resultImage;
}

+ (UIImage *)image:(UIImage *)image replaceColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextTranslateCTM(contextRef, 0.0f, image.size.height);
    CGContextScaleCTM(contextRef, 1.0f,  -1.0f);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, image.CGImage);
    CGContextClipToMask(contextRef, drawRect, image.CGImage);
    CGContextAddRect(contextRef, drawRect);
    CGContextDrawPath(contextRef, kCGPathFill);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //keep original scale and orientation property
    return [UIImage imageWithCGImage:[resultImage CGImage] scale:image.scale orientation:image.imageOrientation];
}

@end
