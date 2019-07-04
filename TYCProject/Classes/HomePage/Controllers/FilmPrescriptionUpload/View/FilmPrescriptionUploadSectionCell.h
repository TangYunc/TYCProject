//
//  FilmPrescriptionUploadSectionCell.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "BaseCell.h"
@class SectionModel;
@class CellModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^FilmPrescriptionUploadSectionCellBlock)(BOOL isExpanded);

@interface FilmPrescriptionUploadSectionCell : BaseCell

@property (nonatomic, strong)SectionModel *sectionModel;
@property (nonatomic, strong)CellModel *cellModel;
@property (nonatomic, copy)FilmPrescriptionUploadSectionCellBlock closeCallback;
//1
@property (nonatomic ,strong) UILabel *orderNumLabel;
@property (nonatomic ,strong) UILabel *orderTimeLabel;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UILabel *payAwayLabel;
@property (nonatomic ,strong) UILabel *sendAwayLabel;
@property (nonatomic ,strong) UIView *gapView1;

//2
@property (nonatomic ,strong) UIImageView *addressImageView;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *phoneNumLabel;
@property (nonatomic ,strong) UILabel *adressLabel;
@property (nonatomic ,strong) UIView *gapView2;

//3
@property (nonatomic ,strong) UILabel *goodAmountLabel;
@property (nonatomic ,strong) UILabel *goodAmountValueLabel;
@property (nonatomic ,strong) UILabel *freightLabel;
@property (nonatomic ,strong) UILabel *freightValueLabel;
@property (nonatomic ,strong) UILabel *amountLabel;
@property (nonatomic ,strong) UIButton *closeBtn;

@end

NS_ASSUME_NONNULL_END
