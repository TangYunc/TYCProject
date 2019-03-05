//
//  UIViewUtil.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/25.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewUtil : NSObject

/////////////////////////////////////////////////////////////////////////////////
/// 创建圆角View
/////////////////////////////////////////////////////////////////////////////////
+ (UIView *)creatRoundCornerView:(CGRect)frame;
/////////////////////////////////////////////////////////////////////////////////
/// 创建Lable
/////////////////////////////////////////////////////////////////////////////////
+(UILabel *)creatLableWithFrame:(CGRect )rect
                           font:(UIFont*)font
                  textAlignment:(NSTextAlignment)textAlignment
                      textColor:(UIColor *)textColor;
/////////////////////////////////////////////////////////////////////////////////
/// 创建按钮
/////////////////////////////////////////////////////////////////////////////////
+(UIButton *)creatButtonWithFrame:(CGRect )rect
                             font:(UIFont*)font
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                    bgNormalImage:(UIImage *)bgNormal
                bgHightLightImage:(UIImage *)bgHighLight;

+(UIView *)creatBadgeViewWithPoint:(CGPoint)point badgeValue:(NSString *)badgeValue;

@end

NS_ASSUME_NONNULL_END
