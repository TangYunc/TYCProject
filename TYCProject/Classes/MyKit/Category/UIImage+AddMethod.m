//
//  UIImage+AddMethod.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "UIImage+AddMethod.h"

@implementation UIImage (AddMethod)
#pragma mark - 根据颜色生成图片
+ (UIImage *)generateImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}
@end
