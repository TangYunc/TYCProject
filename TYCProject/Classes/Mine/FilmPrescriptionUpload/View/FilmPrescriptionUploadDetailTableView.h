//
//  FilmPrescriptionUploadDetailTableView.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SectionModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^FilmPrescriptionUploadDetailTableViewBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface FilmPrescriptionUploadDetailTableView : UITableView

@property (nonatomic ,strong) SectionModel *sectionModel;
@property (nonatomic, copy) FilmPrescriptionUploadDetailTableViewBlock block;

@end

NS_ASSUME_NONNULL_END
