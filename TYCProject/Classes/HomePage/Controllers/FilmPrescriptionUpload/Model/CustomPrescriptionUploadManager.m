//
//  CustomPrescriptionUploadManager.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/21.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "CustomPrescriptionUploadManager.h"

@implementation CustomPrescriptionUploadManager

+ (void)sharePrescriptionUploadManagerJumpConfig:(void(^)(void))jumpConfig{
    
    CustomPrescriptionUploadManager *manager = [[CustomPrescriptionUploadManager alloc] init];
    manager.jumpConfig = jumpConfig;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [YXAlertView shareAlerViewWithTitle:@"" message:@"您与患者已确认将处方照片上传至妙手互联网医院平台" cancelButtonTitle:@"取消" otherButtonTitle:@"确认上传" clickedBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                if (self.jumpConfig) {
                    self.jumpConfig();
                }
            }
        }];
    }
    return self;
}
@end
