//
//  BaseViewController.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic ,strong) void(^confirmBlock)(void);
@property (nonatomic ,strong) void(^cancelBlock)(void);
/** 导航条View */
@property (nonatomic, strong) UIView *navBarView;
@property(nonatomic ) BOOL isHiddenShadowLine;
@property (nonatomic, assign) BOOL isBackButton;
@property(nonatomic ,strong) UIButton *rigthItemButton;

- (void)addChildVc:(UIViewController *)childVc;
- (void)removeChildVc:(UIViewController *)childVc;

- (void)hideNavigationBarShadowLine:(BOOL)hide;
-(void)setNavigationBarTitle:(NSString *)title;

-(void)setNavigationRigthItemTitle:(NSString *)title itemImage:(UIImage *)image action:(SEL)action;
-(void)setNavigationRigthItemTitle:(NSString *)title itemImage:(UIImage *)image;

- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view;
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;

- (void)popAlertViewTipTitle:(NSString *)tipTitle withTipContent:(NSString *)tipContent withChangeStr:(NSString *)changeStr withInfoObject:(nullable id)object confirmBlock:(void(^)(void))confirmBlock cancelBlock:(void(^)(void))cancelBlock;
@end

NS_ASSUME_NONNULL_END
