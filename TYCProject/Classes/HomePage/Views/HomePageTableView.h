//
//  HomePageTableView.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/3/28.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageTableView : UITableView

/**
  UITableView点击单元格交互回调
  */
@property (nonatomic, copy) void(^block)(NSString *title ,NSIndexPath *indexPath);
/**
 每周同样出诊时间开关设置
 */

@property (nonatomic, strong) NSArray *dataLists;

@end

NS_ASSUME_NONNULL_END
