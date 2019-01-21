//
//  AppDelegate+rd3.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "AppDelegate+rd3.h"
#import <AFNetworkReachabilityManager.h>

@implementation AppDelegate (rd3)

- (void)setupAll3Rd:(NSDictionary *)launchOptions
{
    
//    [[SDWebImageManager sharedManager].imageDownloader setValue:nil forHTTPHeaderField:@"Accept"];
}

- (void)listenNetWork
{
    //设置网络监听
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                [Tools showMessage:@"当前使用:未知网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                [Tools showMessage:@"网络连接已断开，请检查网络配置"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
//                [Tools showMessage:@"当前使用:手机网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
//                [Tools showMessage:@"当前使用:WIFI"];
                break;
        }
    }];
    [mgr startMonitoring];
}
@end
