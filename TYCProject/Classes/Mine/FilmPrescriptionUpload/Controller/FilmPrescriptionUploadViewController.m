//
//  FilmPrescriptionUploadViewController.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/17.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionUploadViewController.h"
#import "FilmPrescriptionUploadView.h"
#import "FilmPrescriptionUploadDetailViewController.h"

@interface FilmPrescriptionUploadViewController ()

@property (nonatomic, strong)FilmPrescriptionUploadView *uploadView;

@end

@implementation FilmPrescriptionUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"拍方上传";
    self.isHiddenShadowLine = NO;
    [self setupSubviews];
}

- (void)setupSubviews{
    self.uploadView = [[FilmPrescriptionUploadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.uploadView];
    WS(weakSelf);
    self.uploadView.block = ^(NSDictionary * _Nonnull resultDic) {
        [weakSelf submitPrescription];
    };
}

- (void)submitPrescription{
    DEBUG_LOG(@"点击了提交处方");
    FilmPrescriptionUploadDetailViewController *controller = [[FilmPrescriptionUploadDetailViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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
