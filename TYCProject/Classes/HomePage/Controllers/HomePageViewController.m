//
//  HomePageViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageTableView.h"
#import "FilmPrescriptionUploadViewController.h"
#import "CustomPrescriptionUploadManager.h"
#import "AttributedStringViewController.h"
#import "TitleSegmentViewController.h"
#import "TitleSegmentSecondViewController.h"
#import "TitleSegmentThirdViewController.h"

@interface HomePageViewController ()

@property (nonatomic, strong) HomePageTableView *tableView;
@property (nonatomic, strong) NSArray *dataLists;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    self.dataLists = @[
                       @[@{@"title":HomePageFirstTitle},
                         @{@"title":HomePageSecondTitle},
                         @{@"title":HomePageThirdTitle}
                         ],
                       @[@{@"title":HomePageFourTitle}
                         ],
                       @[@{@"title":HomePageFiveTitle},
                         @{@"title":HomePageSixTitle},
                         @{@"title":HomePageSevenTitle},
                         @{@"title":HomePageEightTitle}
                         ],
                       @[@{@"title":HomePageNineTitle},
                         @{@"title":HomePageTenTitle}
                         ],
                       ];
    [self.view addSubview:self.tableView];
    WS(weakSelf);
    self.tableView.block = ^(NSString * _Nonnull title, NSIndexPath * _Nonnull indexPath) {
        [weakSelf selectTitle:title indexPath:indexPath];
    };
}


-(HomePageTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[HomePageTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataLists = self.dataLists;
    }
    return _tableView;
}

/**
 tableView单元格交互
 
 @param title tableView单元格title
 @param indexPath tableView.indexPath
 */
-(void)selectTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    if ([title isEqualToString:HomePageFirstTitle]) {
        [self homePageFirstTitleClick];
    }else if ([title isEqualToString:HomePageSecondTitle]) {
        [self homePageSecondTitleClick];
    }else if ([title isEqualToString:HomePageThirdTitle]) {
        [self homePageThirdTitleClick];
    }else if ([title isEqualToString:HomePageFourTitle]) {
        [self homePageFourTitleClick];
    }else if ([title isEqualToString:HomePageFiveTitle]) {
        [self homePageFiveTitleClick];
    }else if ([title isEqualToString:HomePageSixTitle]) {
        
    }else if ([title isEqualToString:HomePageSevenTitle]) {
        
    }else if ([title isEqualToString:HomePageEightTitle]) {
        
    }else if ([title isEqualToString:HomePageNineTitle]) {
        
    }else if ([title isEqualToString:HomePageTenTitle]) {
        [self homePageTenTitleClick];
    }
}

#pragma mark -- 交互
- (void)homePageFirstTitleClick{
    NSString *tipContent = @"云来雾去川流不息等伊人，云过天空川身而过终无缘";
    NSString *changeStr = @"云";
    [self popAlertViewTipTitle:@"提示" withTipContent:tipContent withChangeStr:changeStr withInfoObject:nil confirmBlock:^{
        
    } cancelBlock:^{
        
    }];
}

- (void)homePageThirdTitleClick{
    AttributedStringViewController *contrl = [[AttributedStringViewController alloc] init];
    contrl.navigationItem.title = @"改变label字体颜色";
    [self.navigationController pushViewController:contrl animated:YES];
}

- (void)homePageSecondTitleClick{
    
    TitleSegmentViewController *contrl = [[TitleSegmentViewController alloc] init];
    [self.navigationController pushViewController:contrl animated:YES];
}

- (void)homePageFourTitleClick{
    TitleSegmentSecondViewController *contrl = [[TitleSegmentSecondViewController alloc] init];
    [self.navigationController pushViewController:contrl animated:YES];
}

- (void)homePageFiveTitleClick{
    TitleSegmentThirdViewController *contrl = [[TitleSegmentThirdViewController alloc] init];
    [self.navigationController pushViewController:contrl animated:YES];
}



- (void)homePageTenTitleClick{
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
