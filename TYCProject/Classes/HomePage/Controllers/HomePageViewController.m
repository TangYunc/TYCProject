//
//  HomePageViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "HomePageViewController.h"
#import "FilmPrescriptionUploadViewController.h"
#import "CustomPrescriptionUploadManager.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    [self demo1];
}

- (void)demo1{
    UIButton *btn = [UIViewUtil creatButtonWithFrame:CGRectMake(10, 10, 100, 50) font:kSystemFitFont(14) title:@"选择照片" titleColor:RGB_COLOR_WITH_0x(kDocBlueColor) bgNormalImage:nil bgHightLightImage:nil];
    [btn addTarget:self action:@selector(prescriptionUploadClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark -- 按钮事件
- (void)prescriptionUploadClick{
    [CustomPrescriptionUploadManager sharePrescriptionUploadManagerJumpConfig:^{
        
        FilmPrescriptionUploadViewController *controller = [[FilmPrescriptionUploadViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
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
