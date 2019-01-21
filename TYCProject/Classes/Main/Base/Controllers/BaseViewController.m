//
//  BaseViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "BaseViewController.h"
#import "UILabel+AddMethod.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage generateImageFromColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    
    // 去掉下划线
    [self hideNavigationBarShadowLine:YES];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count >1) {
        
        return;
        
    }else {
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc] init];
        _navBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBG"]];
        _navBarView.frame = CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight);
    }
    return _navBarView;
}

- (void)hideNavigationBarShadowLine:(BOOL)hide{
    if (hide) {
        //隐藏导航栏下的线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    else{
        [self.navigationController.navigationBar setShadowImage:nil];
    }
}

#pragma mark -初始化导航栏

- (void)setupNavigationBar {
    
    //导航栏 返回 按钮
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count > 1){
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, SafeAreaTopHeight-65/2.0-6, 94/2.0, 65/2.0);
        [leftButton setImage:[UIImage imageNamed:@"BackNV"] forState:UIControlStateNormal];
        leftButton.adjustsImageWhenHighlighted = NO;
        [leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        
        
    }
    
    [self.view addSubview:self.navBarView];
}

#pragma mark - 设置返回按钮
- (void)setIsBackButton:(BOOL)isBackButton
{
    if (_isBackButton != isBackButton) {
        _isBackButton = isBackButton;
        
        if (_isBackButton == YES) {
            // 创建返回按钮
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0, 0, 56, 56);
            // 设置标题图片
            
            [backButton setImage:[UIImage imageNamed:@"backNV"] forState:UIControlStateNormal];
            [backButton setImage:[UIImage imageNamed:@"backNV"] forState:UIControlStateHighlighted];
            // 设置事件
            [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
            // 创建导航按钮设置到左侧
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        } else {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

#pragma mark -设置导航栏标题

-(void)setNavigationBarTitle:(NSString *)title {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 20, kScreenWidth - 84, kNavigationBarHeight )];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navBarView addSubview:titleLabel];
}

- (void)popAlertViewWithTitle:(NSString *)theTitle Message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherTitle{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:theTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:theTitle];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSForegroundColorAttributeName value:RGB_COLOR_WITH_0x(kBlackTextColor) range:NSMakeRange(0, title.length)];
    [alertController setValue:title forKey:@"attributedTitle"];
    
    if (message.length > 0) {
        
        NSMutableAttributedString *subTitle = [[NSMutableAttributedString alloc] initWithString:message];
        [subTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, subTitle.length)];
        [subTitle addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, subTitle.length)];
        [alertController setValue:subTitle forKey:@"attributedMessage"];
    }
    if (@available(iOS 9.0, *)) {
        UILabel *apperaranceLabel = [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]];
        [apperaranceLabel changeFont:[UIFont systemFontOfSize:15]];
    } else {
        // Fallback on earlier versions
    }
    [cancelAction setValue:RGB_COLOR_WITH_0x(kBlackTextColor) forKey:@"titleTextColor"];
    [otherAction setValue:[UIColor blueColor] forKey:@"titleTextColor"];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 返回按钮事件
- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
