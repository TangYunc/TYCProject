//
//  CustomPrescriptionUploadManager.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/21.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomPrescriptionUploadManager : NSObject

@property (nonatomic ,strong) void(^jumpConfig)(void);

+ (void)sharePrescriptionUploadManagerJumpConfig:(void(^)(void))jumpConfig;
@end

NS_ASSUME_NONNULL_END
