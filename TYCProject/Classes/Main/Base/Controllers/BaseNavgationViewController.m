//
//  BaseNavgationViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "BaseNavgationViewController.h"

@interface BaseNavgationViewController ()

@property(nonatomic) UIActivityIndicatorView *loadingView;

@end

@implementation BaseNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    self.interactivePopGestureRecognizer.delegate = nil;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = UIColorFromRGB(246,246,249);
    self.navigationItem.leftBarButtonItem  = [self leftNavigationItem];
    self.navigationItem.rightBarButtonItem = [self rightNavigationItem];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.translucent = NO;
    [self setUpNavStyle];
}

- (UIBarButtonItem *)leftNavigationItem
{
    return nil;
}

- (UIBarButtonItem *)rightNavigationItem
{
    return nil;
}


- (void)startLoading
{
    if (nil == _loadingView){
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [[UIApplication sharedApplication].keyWindow addSubview:_loadingView];
        _loadingView.center = [UIApplication sharedApplication].keyWindow.center;
    }
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
    [_loadingView startAnimating];
}

- (void)stopLoading
{
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    [_loadingView stopAnimating];
    [_loadingView removeFromSuperview];
    _loadingView = nil;
}

/**
 *  设置导航栏样式，子类可以复写该方法设置自己导航栏样式
 */
- (void)setUpNavStyle
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *norMd = [NSMutableDictionary dictionary];
    norMd[NSForegroundColorAttributeName] = [UIColor whiteColor];
    norMd[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    norMd[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:norMd forState:UIControlStateNormal];
    
    NSMutableDictionary *higMd = [NSMutableDictionary dictionaryWithDictionary:norMd];
    higMd[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:higMd forState:UIControlStateHighlighted];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    UIView *theBJViwe = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
    [self viewColorChangeFromCoror:UIColorFromRGBA(250, 59, 37, 1.0) toColor:UIColorFromRGBA(229, 1, 18, 1.0) withTheView:theBJViwe];
    UIImage *colorImage = [self imageWithUIView:theBJViwe];
    [navBar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    [UIFont systemFontOfSize:18], NSFontAttributeName,
                                    nil]];
}

//视图转换为UILabel
- (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    //    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

- (void)viewColorChangeFromCoror:(UIColor *)fromColor toColor:(UIColor *)toColor withTheView:(UIView *)view{
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [view.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,
                             (__bridge id)toColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.4f), @(1.0f)];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        [viewController.navigationController.navigationItem setHidesBackButton:YES];
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:@"backBtn" higImage:@"backBtn" targe:self action:@selector(back)];
        
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:@"daTuiBtn" higImage:@"daTuiBtn_selected" targe:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:YES];
}

-(void)back
{
    
    [self popViewControllerAnimated:YES];
}

-(void)more
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moreMore" object:nil];
    });
    [self popToRootViewControllerAnimated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIDeviceOrientationPortraitUpsideDown;
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
