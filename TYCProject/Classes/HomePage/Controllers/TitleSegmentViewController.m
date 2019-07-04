//
//  TitleSegmentViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/4/9.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "TitleSegmentViewController.h"
#import "TitleSegmentOneViewController.h"
#import "TitleSegmentSecondViewController.h"
#import "CustomSegmentView.h"

@interface TitleSegmentViewController ()

@property (nonatomic, strong) TitleSegmentOneViewController *oneVC;
@property (nonatomic, strong) TitleSegmentSecondViewController *secondVC;

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *shareRightButton;
@end

@implementation TitleSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 设置导航栏
    [self setUpNavItems];
    
}


// 设置导航栏
- (void)setUpNavItems {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setImage:[UIImage imageNamed:@"TitleSegmentViewLeftIcon"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"TitleSegmentViewLeftIcon"] forState:UIControlStateHighlighted];
    
    // 添加事件
    [leftButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.leftButton = leftButton;
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 22, 22);
    [rightButton setImage:[UIImage imageNamed:@"TitleSegmentViewHeaderEdicIcon"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"TitleSegmentViewHeaderEdicIcon"] forState:UIControlStateHighlighted];
    // 添加事件
    [rightButton addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.hidden = YES;
    self.rightButton = rightButton;
    
    
    
    
    
    UIButton *shareRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareRightButton.frame = CGRectMake(0, 0, 22, 22);
    [shareRightButton setImage:[UIImage imageNamed:@"ShareRightBtnIcon"] forState:UIControlStateNormal];
    [shareRightButton setImage:[UIImage imageNamed:@"ShareRightBtnIcon"] forState:UIControlStateHighlighted];
    // 添加事件
    [shareRightButton addTarget:self action:@selector(shareRightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    shareRightButton.hidden = YES;
    self.shareRightButton = shareRightButton;
    
    
    
    WS(weakSelf);
    __block NSInteger theIndex = 0;
    // 精选关注
    CustomSegmentView *segment = [[CustomSegmentView alloc] initWithItemTitles:@[@"我是控制一", @"我是控制二"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 130, 35);
    segment.customSegmentViewBtnClickHandle = ^(CustomSegmentView * _Nonnull segment, NSString * _Nonnull currentTitle, NSInteger currentIndex) {
        [weakSelf changeChildVcWithCurrentIndex:currentIndex];
        theIndex = currentIndex;
        if (theIndex == 0) {
            [self.rightButton setHidden:YES];
            [self.shareRightButton setHidden:NO];
            UIBarButtonItem *shareRightBarItem = [[UIBarButtonItem alloc] initWithCustomView:shareRightButton];
            self.navigationItem.rightBarButtonItem = shareRightBarItem;
        }else{
            [self.shareRightButton setHidden:YES];
            UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
            self.navigationItem.rightBarButtonItem = rightBarItem;
        }
    };
    if ([self.fromWhere isEqualToString:@"GWVeekerShopControllerShopNotify"]) {
        [segment clickDefault1];
    }else{
        [segment clickDefault];
    }
}

#pragma mark -- methord
- (void)changeChildVcWithCurrentIndex:(NSInteger)currentIndex {
    BOOL isMaterial = (currentIndex == 0);
    
    if (isMaterial) { // 详情
        [self.rightButton setHidden:YES];
        [self.shareRightButton setHidden:NO];
        UIBarButtonItem *shareRightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareRightButton];
        self.navigationItem.rightBarButtonItem = shareRightBarItem;
        [self addChildVc:self.oneVC];
        [self removeChildVc:self.secondVC];
    } else { // 素材
        //        [self.rightButton setHidden:NO];
        [self.shareRightButton setHidden:YES];
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
        self.navigationItem.rightBarButtonItem = rightBarItem;
        [self addChildVc:self.secondVC];
        [self removeChildVc:self.oneVC];
    }
}

- (TitleSegmentOneViewController *)oneVC {
    if (!_oneVC) {
        _oneVC = [[TitleSegmentOneViewController alloc] init];
        [self addChildVc:_oneVC];
    }
    return _oneVC;
}

- (TitleSegmentSecondViewController *)secondVC {
    if (!_secondVC) {
        _secondVC = [[TitleSegmentSecondViewController alloc] init];
        [self addChildVc:_secondVC];
    }
    return _secondVC;
}

#pragma mark -- 按钮点击事件
- (void)rightItemClick {
    
}

- (void)shareRightButtonItemClick{
    
}
@end
