//
//  CustomTabBar.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

-(void)tabBar:(CustomTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to;
-(void)tabBarPresentViewController:(CustomTabBar *)tabBar;
-(void)selectTabItem:(NSInteger)index;
- (void)tabBarPlusBtnClick:(CustomTabBar *)tabBar;

@end

@interface CustomTabBar : UIView

@property (nonatomic, weak) id <CustomTabBarDelegate> delegate;
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic, strong) UILabel *tabBarLabel;


-(void)addTabBarButton:(UITabBarItem *)item;
-(void)selectTabItem:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
