//
//  FilmPrescriptionUploadOrderHeadView.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/19.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionUploadOrderHeadView.h"
#import "SectionModel.h"

@interface FilmPrescriptionUploadOrderHeadView ()

@property (nonatomic, strong)UILabel *orderNumLabel;
@property (nonatomic, strong)UILabel *payLabel;
@property (nonatomic, strong)UIButton *expandedBtn;

@end

@implementation FilmPrescriptionUploadOrderHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    
        //订单编号
        self.orderNumLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
        [self.contentView addSubview:self.orderNumLabel];
        
        //实付款
        self.payLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(14) textAlignment:NSTextAlignmentRight textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
        [self.contentView addSubview:self.payLabel];
        
        //展开按钮
        
        self.expandedBtn = [UIViewUtil creatButtonWithFrame:CGRectZero font:kSystemFitFont(14) title:@"展开全部信息" titleColor:RGB_COLOR_WITH_0x(kBlackText999Color) bgNormalImage:nil bgHightLightImage:nil];
        self.expandedBtn.layer.borderColor = RGB_COLOR_WITH_0x(0xe8e8e8).CGColor;
        self.expandedBtn.layer.borderWidth = 0.5;
        [self.expandedBtn setImage:[UIImage imageNamed:@"icon_xjt"] forState:UIControlStateNormal];
        [self.expandedBtn addTarget:self action:@selector(expandedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.expandedBtn];
        
        self.contentView.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = KFloat(15);
    CGFloat topMargin = leftMargin;
    CGFloat rightMargin = leftMargin;
    CGFloat labelHeight = KFloat(14);
    NSString *orderNum = [NSString stringWithFormat:@"订单编号：%@", self.sectionModel.orderNum];
    CGFloat orderNumLabelWidth = [orderNum calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitFont(14) isWidth:YES].width;
    self.orderNumLabel.frame = CGRectMake(leftMargin, topMargin, orderNumLabelWidth, labelHeight);
    self.orderNumLabel.text = orderNum;
    
    NSString *pay = [NSString stringWithFormat:@"实付款：%@", self.sectionModel.pay];
    CGFloat payLabelWidth = [orderNum calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitFont(14) isWidth:YES].width;
    self.payLabel.frame = CGRectMake(0, topMargin, payLabelWidth, labelHeight);
    self.payLabel.right = self.frame.size.width - rightMargin;
    self.payLabel.text = pay;
    
    CGFloat expandedBtnWidth = KFloat(135);
    CGFloat expandedBtnHeight = KFloat(30);
    CGFloat topSpacing = self.frame.size.height - KFloat(18) - expandedBtnHeight;
    CGFloat leftSpacing = (self.frame.size.width - expandedBtnWidth) / 2;
    self.expandedBtn.frame = CGRectMake(leftSpacing, topSpacing, expandedBtnWidth, expandedBtnHeight);
    self.expandedBtn.layer.cornerRadius = expandedBtnHeight / 2;
    [self.expandedBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.expandedBtn.imageView.image.size.width, 0, self.expandedBtn.imageView.image.size.width + 5)];
    [self.expandedBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.expandedBtn.titleLabel.bounds.size.width + 5, 0, -self.expandedBtn.titleLabel.bounds.size.width)];
}
//- (void)setSectionModel:(SectionModel *)sectionModel {
//
//    if (_sectionModel != sectionModel) {
//
//        _sectionModel = sectionModel;
//    }
//
//}

- (void)expandedBtnClick:(UIButton *)sender {
    
    self.sectionModel.isExpanded = !self.sectionModel.isExpanded;
    
    if (self.expandCallback) {
        self.expandCallback(self.sectionModel.isExpanded);
    }
}

@end
