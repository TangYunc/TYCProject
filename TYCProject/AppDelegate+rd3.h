//
//  AppDelegate+rd3.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (rd3)

//初始化所有第三方
- (void)setupAll3Rd:(NSDictionary *)launchOptions;

- (void)listenNetWork;

@end

NS_ASSUME_NONNULL_END
