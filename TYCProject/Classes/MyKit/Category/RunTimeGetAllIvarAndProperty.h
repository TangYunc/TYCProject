//
//  RunTimeGetAllIvarAndProperty.h
//  AlertAciton
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 Mr_Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface RunTimeGetAllIvarAndProperty : NSObject

//通过运行时获取KEY
//获得所有变量
+ (NSArray *)getAllIvar:(id)object;
//获得所有属性
+ (NSArray *)getAllProperty:(id)object;
@end
