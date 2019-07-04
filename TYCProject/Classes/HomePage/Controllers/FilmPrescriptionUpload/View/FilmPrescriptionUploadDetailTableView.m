//
//  FilmPrescriptionUploadDetailTableView.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionUploadDetailTableView.h"
#import "UITableViewCell+ShareCell.h"
#import "PrescriptionBuyDrugBottomAlertView.h"
#import "FilmPrescriptionUploadDetailStatuCell.h"
#import "FilmPrescriptionUploadOrderHeadView.h"
#import "SectionModel.h"
#import "FilmPrescriptionUploadSectionCell.h"

#define kHeadIdentifier @"kHeadIdentifier"

@interface FilmPrescriptionUploadDetailTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSIndexPath *theIndexPath;
@property (nonatomic ,strong) UIView *theFooterView;

@end

@implementation FilmPrescriptionUploadDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[FilmPrescriptionUploadOrderHeadView class] forHeaderFooterViewReuseIdentifier:kHeadIdentifier];
        self.sectionModel = [[SectionModel alloc] init];
        self.sectionModel.address = @"地址：北京朝阳区三环以内北京市朝阳区双井荒木厂路北起资产大厦1好流6层";
        self.sectionModel.orderNum = @"7823333";
        self.sectionModel.pay = @"$24.00";
        self.sectionModel.freight = @"$12.00";
        self.sectionModel.isExpanded = NO;
    }
    return self;
}

-(UIView *)theFooterView{
    if (!_theFooterView) {
        CGFloat height = KFloat(65);
        _theFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        PrescriptionBuyDrugBottomAlertView *alertView = [[PrescriptionBuyDrugBottomAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        alertView.tipInfo = @"备注：若有疑问可拨打妙手客服电话：400-070-1000";
        [_theFooterView addSubview:alertView];
    }
    return _theFooterView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.sectionModel.isExpanded ? 1 : 0;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (!section) {
        FilmPrescriptionUploadDetailStatuCell *cell = [FilmPrescriptionUploadDetailStatuCell  shareCellTableView:tableView reuseIdentifier:@"FilmPrescriptionUploadDetailStatuCell"];
        cell.statu = @"1";
        return cell;
    }else if (section == 1) {
        FilmPrescriptionUploadSectionCell *cell = [FilmPrescriptionUploadSectionCell  shareCellTableView:tableView reuseIdentifier:@"FilmPrescriptionUploadSectionCell"];
        cell.sectionModel = self.sectionModel;
        cell.closeCallback = ^(BOOL isExpanded) {
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return cell;
    }else {
        FilmPrescriptionUploadDetailCheckCell *cell = [FilmPrescriptionUploadDetailCheckCell  shareCellTableView:tableView reuseIdentifier:@"FilmPrescriptionUploadDetailCheckCell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (!section) {
        return KFloat(60);
    }else if (section == 1) {
        return self.sectionModel.cellHeight;
    }else {
        return KFloat(50);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat headerHeight = 0.5;
    if (!section) {
        headerHeight = 0.5;
    }else if (section == 1) {
        headerHeight = self.sectionModel.isExpanded ? 0.5 : KFloat(95);
    }else {
        headerHeight = 0.5;
    }
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1){
        FilmPrescriptionUploadOrderHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeadIdentifier];
        view.sectionModel = self.sectionModel;
        view.expandCallback = ^(BOOL isExpanded) {
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return view = self.sectionModel.isExpanded ? nil : view;
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerHeight = 0;
    footerHeight = KFloat(10);
    if (section == 2) {
        footerHeight = KFloat(65);
    }
    return footerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    view.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
    if (section == 3) {
        return self.theFooterView;
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.theIndexPath = indexPath;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:cell];
    [self performSelector:@selector(todoSomething:)withObject:cell afterDelay:0.5f];
    
}

- (void)todoSomething:(id)sender
{
    if (self.block) {
        self.block(self, self.theIndexPath);
    }
}


@end
