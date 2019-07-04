//
//  FilmPrescriptionUploadSectionCell.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionUploadSectionCell.h"
#import "SectionModel.h"

@implementation FilmPrescriptionUploadSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        //初始化子视图
        [self initSubviews];
    }
    return self;
}

//初始化子视图
- (void)initSubviews{
    
    //1.
    //订单编号
    self.orderNumLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.orderNumLabel];
    
    //下单时间
    self.orderTimeLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.orderTimeLabel];
    
    //间隔线
    self.lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = RGB_COLOR_WITH_0x(kCellLineViewColor);
    [self.contentView addSubview:self.lineView];
    
    //支付方式
    self.payAwayLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.payAwayLabel];
    
    //配送方式
    self.sendAwayLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.sendAwayLabel];
    
    //间隙视图
    self.gapView1 = [[UIView alloc] initWithFrame:CGRectZero];
    self.gapView1.backgroundColor = RGB_COLOR_WITH_0x(kBgViewColor);
    [self.contentView addSubview:self.gapView1];
    
    //2.
    //位置icon
    self.addressImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.addressImageView];
    
    //订单用户名
    self.nameLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.nameLabel];
    
    //订单用户电话
    self.phoneNumLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.phoneNumLabel];
    
    //订单用户地址
    self.adressLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    self.adressLabel.numberOfLines = 2;
    [self.contentView addSubview:self.adressLabel];
    
    //间隙视图
    self.gapView2 = [[UIView alloc] initWithFrame:CGRectZero];
    self.gapView2.backgroundColor = RGB_COLOR_WITH_0x(kBgViewColor);
    [self.contentView addSubview:self.gapView2];
    
    //3.
    //商品总额
    self.goodAmountLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.goodAmountLabel];
    
    //商品总额value
    self.goodAmountValueLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.goodAmountValueLabel];
    
    //运费
    self.freightLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.freightLabel];
    
    //运费value
    self.goodAmountValueLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:self.goodAmountValueLabel];
    
    //合计金额
    self.amountLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(0xe96f2d)];
    [self.contentView addSubview:self.amountLabel];
    
    //收起按钮
    
    self.closeBtn = [UIViewUtil creatButtonWithFrame:CGRectZero font:kSystemFitFont(14) title:@"收起" titleColor:RGB_COLOR_WITH_0x(kBlackText999Color) bgNormalImage:nil bgHightLightImage:nil];
    self.closeBtn.layer.borderColor = RGB_COLOR_WITH_0x(0xe8e8e8).CGColor;
    self.closeBtn.layer.borderWidth = 0.5;
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_sjt"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.closeBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftMargin = KFloat(15);
    CGFloat topMargin = leftMargin;
    CGFloat gapSpacing = leftMargin;
    CGFloat labelWidth = self.frame.size.width - leftMargin * 2;
    CGFloat labelHeight = KFloat(14);
    CGFloat bottomMargin = KFloat(18);
    CGFloat spacing = KFloat(10);
    CGFloat spacing1 = spacing;
    CGFloat spacing2 = KFloat(20);
    //1.
    NSString *orderNum = @"订单编号：7829999";
    self.orderNumLabel.frame = CGRectMake(leftMargin, topMargin, labelWidth, labelHeight);
    self.orderNumLabel.text = orderNum;
    self.orderNumLabel.attributedText = [self.orderNumLabel.text setAttributedWithIdentifyString:@"订单编号：" font:kSystemFitBordFont(14)];
    
    NSString *orderTime = @"下单时间：2018-01-21  12：00";
    self.orderTimeLabel.frame = CGRectMake(leftMargin, self.orderNumLabel.bottom + gapSpacing, labelWidth, labelHeight);
    self.orderTimeLabel.text = orderTime;
    self.orderTimeLabel.attributedText = [self.orderTimeLabel.text setAttributedWithIdentifyString:@"下单时间：" font:kSystemFitBordFont(14)];
    
    self.lineView.frame = CGRectMake(0, self.orderTimeLabel.bottom + bottomMargin, kScreenWidth, 0.5);
    
    NSString *payAway = @"支付方式：货到付款";
    self.payAwayLabel.frame = CGRectMake(leftMargin, self.lineView.bottom + gapSpacing, labelWidth, labelHeight);
    self.payAwayLabel.text = payAway;
    self.payAwayLabel.attributedText = [self.payAwayLabel.text setAttributedWithIdentifyString:@"支付方式：" font:kSystemFitBordFont(14)];
    
    NSString *sendAway = @"配送方式：药品配送";
    self.sendAwayLabel.frame = CGRectMake(leftMargin, self.payAwayLabel.bottom + gapSpacing, labelWidth, labelHeight);
    self.sendAwayLabel.text = sendAway;
    self.sendAwayLabel.attributedText = [self.sendAwayLabel.text setAttributedWithIdentifyString:@"配送方式：" font:kSystemFitBordFont(14)];
    
    self.gapView1.frame = CGRectMake(0, self.sendAwayLabel.bottom + bottomMargin, self.frame.size.width, spacing);
    
    //2.
    UIImage *addressIcon = [UIImage imageNamed:@"icon_dz"];
    self.addressImageView.frame = CGRectMake(leftMargin, self.gapView1.bottom + spacing2, addressIcon.size.width, addressIcon.size.height);
    self.addressImageView.image = addressIcon;
    
    NSString *name = @"张娜拉";
    CGFloat nameLabelWidth = [name calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitBordFont(14) isWidth:YES].width;
    self.nameLabel.frame = CGRectMake(self.addressImageView.right + spacing1, self.addressImageView.top, nameLabelWidth, labelHeight);
    self.nameLabel.text = name;
    
    NSString *phoneNum = [@"18642314018" changeTelephone];
    CGFloat phoneNumLabelWidth = [phoneNum calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitBordFont(14) isWidth:YES].width;
    self.phoneNumLabel.frame = CGRectMake(self.nameLabel.right + spacing2, self.nameLabel.top, phoneNumLabelWidth, labelHeight);
    self.phoneNumLabel.text = phoneNum;
    
    NSString *address = @"地址：北京朝阳区三环以内北京市朝阳区双井荒木厂路北起资产大厦1好流6层";
    CGFloat adressLabelWidth = self.frame.size.width - self.nameLabel.left - leftMargin;
    CGFloat adressLabelHeight = [address calculatlabelWidthLabelWidth:adressLabelWidth labelHeight:0 font:kSystemFitFont(14) isWidth:NO].height;
    self.adressLabel.frame = CGRectMake(self.nameLabel.left, self.nameLabel.bottom + gapSpacing, adressLabelWidth, adressLabelHeight);
    self.adressLabel.text = address;
    
    self.gapView2.frame = CGRectMake(0, self.adressLabel.bottom + spacing2, self.frame.size.width, spacing);
    
    //3.
    NSString *goodAmount = @"商品总额：";
    CGFloat goodAmountLabelWidth = [goodAmount calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitBordFont(14) isWidth:YES].width;
    self.goodAmountLabel.frame = CGRectMake(leftMargin, self.gapView2.bottom + spacing2, goodAmountLabelWidth, labelHeight);
    self.goodAmountLabel.text = goodAmount;
    
    NSString *goodAmountValue = @"¥12.00";
    CGFloat goodAmountValueLabelWidth = [goodAmountValue calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitBordFont(14) isWidth:YES].width;
    self.goodAmountValueLabel.frame = CGRectMake(0, self.goodAmountLabel.top, goodAmountValueLabelWidth, labelHeight);
    self.goodAmountValueLabel.text = goodAmountValue;
    self.goodAmountValueLabel.right = self.frame.size.width - leftMargin;
    
    NSString *freight = @"运费：";
    CGFloat freightLabelWidth = [freight calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitBordFont(14) isWidth:YES].width;
    self.freightLabel.frame = CGRectMake(leftMargin, self.goodAmountLabel.bottom + gapSpacing, freightLabelWidth, labelHeight);
    self.freightLabel.text = freight;
    
    NSString *freightValue = @"¥12.00";
    CGFloat freightValueLabelWidth = [freightValue calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitBordFont(14) isWidth:YES].width;
    self.freightValueLabel.frame = CGRectMake(0, self.freightLabel.top, freightValueLabelWidth, labelHeight);
    self.freightValueLabel.text = freightValue;
    self.freightValueLabel.right = self.goodAmountValueLabel.right;
    
    NSString *amount = @"合计金额：¥24.00";
    CGFloat amountLabelWidth = [amount calculatlabelWidthLabelWidth:0 labelHeight:labelHeight font:kSystemFitBordFont(14) isWidth:YES].width;
    self.amountLabel.frame = CGRectMake(0, 0, amountLabelWidth, labelHeight);
    self.amountLabel.text = amount;
    self.amountLabel.right = self.goodAmountValueLabel.right;
    self.amountLabel.attributedText = [self.amountLabel.text setAttributedWithIdentifyString:@"合计金额：" color:RGB_COLOR_WITH_0x(kBlackTextColor)];
    
    CGFloat closeBtnWidth = KFloat(135);
    CGFloat closeBtnHeight = KFloat(30);
    self.closeBtn.frame = CGRectMake(0, 0, closeBtnWidth, closeBtnHeight);
    self.closeBtn.layer.cornerRadius = closeBtnHeight / 2;
    self.closeBtn.centerX = self.centerX;
    self.closeBtn.bottom = self.height - spacing2;
    self.amountLabel.bottom = self.closeBtn.top - spacing2;
    [self.closeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.closeBtn.imageView.size.width, 0, self.closeBtn.imageView.size.width + 5)];
    [self.closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.closeBtn.titleLabel.bounds.size.width + 5, 0, -self.closeBtn.titleLabel.bounds.size.width)];
    
}


#pragma mark -- 按钮事件
- (void)closeBtnClick{
    DEBUG_LOG(@"点击了收起按钮");
    self.sectionModel.isExpanded = !self.sectionModel.isExpanded;
    
    if (self.closeCallback) {
        self.closeCallback(self.sectionModel.isExpanded);
    }
}

@end
