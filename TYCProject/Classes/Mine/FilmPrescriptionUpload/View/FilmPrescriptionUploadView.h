//
//  FilmPrescriptionUploadView.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/17.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FilmPrescriptionUploadViewBlock)(NSDictionary *resultDic);

@interface FilmPrescriptionUploadView : UIScrollView

@property (nonatomic, copy) FilmPrescriptionUploadViewBlock block;

@end

NS_ASSUME_NONNULL_END
