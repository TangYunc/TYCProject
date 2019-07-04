//
//  FilmPrescriptionView.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/17.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FilmPrescriptionViewBlock)(NSArray *selectedPhotos);
typedef void(^FilmPrescriptionViewWBlock)(CGFloat currentViewWidth);

@interface FilmPrescriptionView : UIView

@property (nonatomic, copy)NSString *fromWhere;
@property (nonatomic, copy)FilmPrescriptionViewBlock block;
@property (nonatomic, copy)FilmPrescriptionViewWBlock widthBlock;
@property (nonatomic ,strong) NSString *imageUrl;//示例图片

@end

NS_ASSUME_NONNULL_END
