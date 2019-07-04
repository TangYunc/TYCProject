//
//  HomePageTableView.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/3/28.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "HomePageTableView.h"
#import "HomePageCell.h"

@interface HomePageTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSIndexPath *theIndexPath;
@property (nonatomic, strong) UISwitch *switchFunc;

@end

@implementation HomePageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor orangeColor];
        self.rowHeight = KFloat(54.5);
        
    }
    return self;
}


-(UISwitch *)switchFunc{
    if(!_switchFunc){
        _switchFunc = [[UISwitch alloc]init];
        [_switchFunc setBackgroundColor:RGB_COLOR_WITH_0x(kBgViewColor)];
        [_switchFunc setTintColor:RGB_COLOR_WITH_0x(kBgViewColor)];
        [_switchFunc setOnTintColor:RGB_COLOR_WITH_0x(kBlueColor)];
        [_switchFunc setThumbTintColor:RGB_COLOR_WITH_0x(kWhiteColor)];
        _switchFunc.layer.cornerRadius = 15.5f;
        _switchFunc.layer.masksToBounds = YES;
        [_switchFunc addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchFunc;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataLists.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *theArr = self.dataLists[section];
    return theArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomePageCell *theCell = [HomePageCell shareCellTableView:tableView reuseIdentifier:@"BROutpatientInforSettingsCell"];
    UIImageView *cellAssistantIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 17)];
    cellAssistantIcon.image = [UIImage imageNamed:@"recording_arrow"];
    theCell.accessoryView = cellAssistantIcon;
    NSArray *theArr = self.dataLists[indexPath.section];
    theCell.theDic = theArr[indexPath.row];
    return theCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *theArr = self.dataLists[indexPath.section];
    if (indexPath.row == (theArr.count - 1)) {
        
        HomePageCell *theCell = (HomePageCell *)cell;
        theCell.bottomLine.hidden = YES;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *gapView = [[UIView alloc] init];
    if (section != 0) {
        gapView.backgroundColor = RGB_COLOR_WITH_0x(kBgViewColor);
    }
    return gapView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return KFloat(10);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return KFloat(54.5);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.theIndexPath = indexPath;
    HomePageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:cell];
    [self performSelector:@selector(todoSomething:)withObject:cell afterDelay:0.5f];
    
}

- (void)todoSomething:(id)sender
{
    HomePageCell *cell = (HomePageCell *)sender;
    if (self.block) {
        self.block(cell.theDic[@"title"], self.theIndexPath);
    }
}

#pragma mark -- 事件
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    DEBUG_LOG(@"%@", @(isButtonOn));
}

@end
