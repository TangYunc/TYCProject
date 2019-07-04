//
//  TitleSegmentSecondViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/4/9.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "TitleSegmentSecondViewController.h"

@interface TitleSegmentSecondViewController ()
{
    //结构体 位域
    struct {
        unsigned int isLod : 1; //是否插播  1位
        unsigned int isAS : 1;  //是否桌面共享 1位
        unsigned int isCameraShow : 1;  //是否本地视频 1位
        unsigned int isFullScreen : 1;  //是否全屏 1位
        
        unsigned int isDisplay : 1;
        unsigned int isSpeaker : 1;
        unsigned int isRotation : 1;
    } _state;
}
@end

@implementation TitleSegmentSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"横屏测试";
    [self setupSubviews];
}

- (void)setupSubviews{
    UILabel *titleLabel = [UIViewUtil creatLableWithFrame:CGRectMake(100, 200, 100, 30) font:kSystemFitFont(17) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    titleLabel.text = self.navigationItem.title;
    [self.view addSubview:titleLabel];
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tapGR.numberOfTapsRequired = 2;
    [titleLabel addGestureRecognizer:tapGR];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotationAction) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)updateScreenOriention:(UIDeviceOrientation)oriention{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = oriention;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)rotationAction {
    UIInterfaceOrientation statusOrient = [UIApplication sharedApplication].statusBarOrientation;
    
    if (statusOrient == UIInterfaceOrientationLandscapeRight){
        _state.isFullScreen = 1;
        
        
        self.navigationController.navigationBar.hidden = YES;
        
        
    }else if (statusOrient == UIInterfaceOrientationPortrait){
        _state.isFullScreen = 0;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        self.navigationController.navigationBar.hidden = NO;
        
    }
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationLandscapeRight;
}

#pragma mark -- 手势
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (_state.isFullScreen) {
        [self updateScreenOriention:UIDeviceOrientationPortrait];
    }else{
        [self updateScreenOriention:UIDeviceOrientationLandscapeLeft];
    }
}
@end
