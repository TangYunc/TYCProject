//
//  FilmPrescriptionUploadOrderHeadView.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/19.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SectionModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^FilmPrescriptionUploadOrderHeadViewBlock)(BOOL isExpanded);

@interface FilmPrescriptionUploadOrderHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong)SectionModel *sectionModel;
@property (nonatomic, copy)FilmPrescriptionUploadOrderHeadViewBlock expandCallback;

@end

NS_ASSUME_NONNULL_END
