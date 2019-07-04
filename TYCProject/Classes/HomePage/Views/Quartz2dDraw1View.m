//
//  Quartz2dDraw1View.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/4/22.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "Quartz2dDraw1View.h"

@implementation Quartz2dDraw1View

- (void)drawRect:(CGRect)rect {
    
    
    //    [self drawTriangle];
    
    [self drawRoundForLabelRect:rect];
    
}

- (void)drawRoundForLabelRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    CGFloat radius = (width + height) * 0.05;
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    // 闭合路径
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    // 填充半透明粉红色
    CGContextSetRGBFillColor(context, 100.0, 0.0, 0.0, 0.5);
    CGContextDrawPath(context, kCGPathFill|kCGPathFillStroke);
}

- (void)drawTriangle{
    //获取图形上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //设置点
    CGContextMoveToPoint(contextRef, 100, 100);
    CGContextAddLineToPoint(contextRef, 200, 200);
    CGContextAddLineToPoint(contextRef, 100, 200);
    
    //把点封闭起来
    CGContextClosePath(contextRef);
    
    //设置线宽
    CGContextSetLineWidth(contextRef, 3.0f);
    //设置线的颜色
    CGContextSetStrokeColorWithColor(contextRef, [UIColor redColor].CGColor);
    //设置填充颜色
    CGContextSetFillColorWithColor(contextRef, [UIColor greenColor].CGColor);
    
    
    // 如果写了多种渲染方式，那么只执行第一种
    //    CGContextStrokePath(contextRef);
    //    CGContextFillPath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
}
@end
