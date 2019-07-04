//
//  SectionModel.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionModel : NSObject

//section模型里面包含的cell模型集合
@property (nonatomic, strong)NSMutableArray *cellModels;
//判断section点击状态，达到展开收起效果
@property (nonatomic, assign)BOOL isExpanded;
@property (nonatomic, copy)NSString *orderNum;
@property (nonatomic, copy)NSString *pay;
@property (nonatomic, copy)NSString *freight;

@property (nonatomic, copy) NSString *address;
@property (nonatomic) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
