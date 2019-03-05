//
//  BaseNavgationViewController.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavgationViewController : UINavigationController

/**
 *  设置导航栏样式，子类可以复写该方法设置自己导航栏样式
 */
- (void)setUpNavStyle;

- (UIBarButtonItem *)leftNavigationItem;
- (UIBarButtonItem *)rightNavigationItem;

@end

NS_ASSUME_NONNULL_END
