//
//  TitleSegmentThirdViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/4/22.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "TitleSegmentThirdViewController.h"
#import "Quartz2dDraw1View.h"

@interface TitleSegmentThirdViewController ()

@end

@implementation TitleSegmentThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"绘制";
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
}

#pragma mark -- 手势
- (void)tapAction:(UITapGestureRecognizer *)tap{
    Quartz2dDraw1View *drawView = [[Quartz2dDraw1View alloc]init];
    drawView.frame = CGRectMake(100, 300, 100, 50);
    drawView.backgroundColor = [UIColor whiteColor];
    [drawView setNeedsDisplay];
    [self.view addSubview:drawView];
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
