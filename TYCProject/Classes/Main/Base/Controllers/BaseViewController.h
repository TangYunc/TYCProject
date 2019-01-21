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

/** 导航条View */
@property (nonatomic, strong) UIView *navBarView;

@property (nonatomic, assign) BOOL isBackButton;
- (void)hideNavigationBarShadowLine:(BOOL)hide;
-(void)setNavigationBarTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
