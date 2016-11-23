//
//  UIImage+ColorReplacement.h
//  Animation
//
//  Created by Allen on 11/22/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorReplacement)

+ (UIImage *)imageNamed:(NSString *)name replaceColor:(UIColor *)color;

+ (UIImage *)image:(UIImage *)image replaceColor:(UIColor *)color;

@end
