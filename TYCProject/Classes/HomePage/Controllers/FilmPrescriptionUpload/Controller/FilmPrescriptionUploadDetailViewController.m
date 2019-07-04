//
//  FilmPrescriptionUploadDetailViewController.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionUploadDetailViewController.h"
#import "FilmPrescriptionUploadDetailTableView.h"

@interface FilmPrescriptionUploadDetailViewController ()

@property (nonatomic, strong) NSArray *dataLists;
@property (nonatomic, strong) FilmPrescriptionUploadDetailTableView *tableView;

@end

@implementation FilmPrescriptionUploadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"拍方上传详情";
    self.isHiddenShadowLine = NO;
    [self.view addSubview:self.tableView];
    WS(weakSelf);
    self.tableView.block = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [weakSelf interactiveTableViewIndexPath:indexPath];
    };
}

-(FilmPrescriptionUploadDetailTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[FilmPrescriptionUploadDetailTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)interactiveTableViewIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        DEBUG_LOG(@"点击查看上传处方");
    }
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
