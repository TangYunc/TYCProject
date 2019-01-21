//
//  BaseTabBarViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavgationViewController.h"
#import "CustomTabBar.h"
#import "HomePageViewController.h"
#import "MineViewController.h"

@interface BaseTabBarViewController ()<CustomTabBarDelegate>

@property(nonatomic, strong)CustomTabBar *customTabBar;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addViewControllers];
}

- (CustomTabBar *)customTabBar{
    if (!_customTabBar) {
        _customTabBar = [[CustomTabBar alloc] init];
        _customTabBar.frame = self.tabBar.bounds;
        [self.tabBar addSubview:_customTabBar];
        _customTabBar.delegate = self;
    }
    return _customTabBar;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[UIControl class]]) {
            [subView removeFromSuperview];
        }
    }
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [child removeFromSuperview];
        }
    }
}

- (void)addViewControllers
{
    NSArray *contrls = @[@[HomePageViewController.class,@"首页",@"btn_main",@"btn_main_s"],
                    @[MineViewController.class,@"我的",@"btn_mine",@"btn_mine_s"]
                    ];
    NSMutableArray * tabArray = [NSMutableArray arrayWithArray:contrls];
    
    
    for (NSArray *contrl in tabArray) {
        [self addOneChildViewController:[[contrl[0] alloc]init] title:contrl[1] norImage:contrl[2] selectedImage:contrl[3]];
    }
}

#pragma mark 加载四个控制器
-(void)addOneChildViewController:(UIViewController *)childVc title:(NSString *)title norImage:(NSString *)norImage selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:norImage];
    
    UIImage *selImage = [UIImage imageNamed:selectedImage];
    if (isIOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selImage;
    
    
    BaseNavgationViewController *nav = [[BaseNavgationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.customTabBar  addTabBarButton:childVc.tabBarItem];
    
}

#pragma mark - YDTabBarDelegate
-(void)tabBar:(CustomTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to
{
    NSLog(@"%zd",to);
    
    self.selectedIndex = to;
}

-(void)tabBarPresentViewController:(CustomTabBar *)tabBar{
    
}

-(void)selectTabItem:(NSInteger)index{
    NSLog(@"index:%ld",(long)index);
}

#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(CustomTabBar *)tabBar{
    
    UIViewController *plusVC = [[UIViewController alloc] init];
    plusVC.view.backgroundColor = [UIColor whiteColor];
    BaseNavgationViewController *navVC = [[BaseNavgationViewController alloc] initWithRootViewController:plusVC];
    [self presentViewController:navVC animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
