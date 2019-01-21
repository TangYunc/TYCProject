//
//  CustomNavigationView.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomNavigationView : UIView

@property (weak,nonatomic)UIViewController *viewController;

@property (nonatomic ,assign) NSString *title;
//左侧返回
- (instancetype)initWithFrame:(CGRect)frame andLeftBtn:(NSString *)title;

//右侧返回
- (instancetype)initWithFrame:(CGRect)frame andRightBtn:(NSString *)title;

//无返回
- (instancetype)initWithFrame:(CGRect)frame andtitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
