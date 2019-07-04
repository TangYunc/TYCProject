//
//  FilmPrescriptionUploadView.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/17.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionUploadView.h"
#import "FooterButtonView.h"
#import "FilmPrescriptionView.h"

@interface FilmPrescriptionUploadView ()

@property (nonatomic ,strong) UIView *submitButtonView;
@property (nonatomic, strong) FilmPrescriptionView *filmPresctiptionView;
@property (nonatomic, strong) UIView *medicalUseView;
@property (nonatomic, strong) UIView *inquiryFeeView;
@end

@implementation FilmPrescriptionUploadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 当拖动时移除键盘
        [self setupSubviews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)setupSubviews{
    
    //1.医生开方药房
    CGFloat leftMargin = KFloat(15);
    CGFloat labelHeight = KFloat(15);
    CGFloat viewHeight = KFloat(51);
    CGFloat spacing = KFloat(10);
    UIView *doctorPharmacyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)];
    doctorPharmacyView.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
    [self addSubview:doctorPharmacyView];
    NSString *doctorPharmacyStr = @"医生开方药房";
    CGFloat doctorPharmacyLabelWidth = [self calculatlabelWidthValue:doctorPharmacyStr labelHeight:labelHeight font:kSystemFitFont(15)];
    UILabel *doctorPharmacyLabel = [UIViewUtil creatLableWithFrame:CGRectMake(leftMargin, 0, doctorPharmacyLabelWidth, labelHeight) font:kSystemFitFont(15) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [doctorPharmacyView addSubview:doctorPharmacyLabel];
    doctorPharmacyLabel.centerY = doctorPharmacyView.centerY;
    doctorPharmacyLabel.text = doctorPharmacyStr;
    
    NSString *doctorPharmacyValue = @"湖北新特大药房";
    CGFloat doctorPharmacyWidth = [self calculatlabelWidthValue:doctorPharmacyValue labelHeight:labelHeight font:kSystemFitFont(15)];
    UILabel *doctorPharmacyValueLabel = [UIViewUtil creatLableWithFrame:CGRectMake(0, doctorPharmacyLabel.top, doctorPharmacyWidth, labelHeight) font:kSystemFitFont(15) textAlignment:NSTextAlignmentRight textColor:RGB_COLOR_WITH_0x(kDocBlueColor)];
    [doctorPharmacyView addSubview:doctorPharmacyValueLabel];
    doctorPharmacyValueLabel.right = doctorPharmacyView.right - leftMargin;
    doctorPharmacyValueLabel.text = doctorPharmacyValue;
    
    //2问诊服务
    UIView *inquiryServiceView = [[UIView alloc] initWithFrame:CGRectMake(0, UIViewBottomY(doctorPharmacyView) + spacing, kScreenWidth, 0)];
    inquiryServiceView.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
    [self addSubview: inquiryServiceView];
    
    NSString *inquiryServiceStr = @"问诊服务";
    CGFloat inquiryServiceLabelWidth = [self calculatlabelWidthValue:inquiryServiceStr labelHeight:labelHeight font:kSystemFitFont(15)];
    UILabel *inquiryServiceLabel = [UIViewUtil creatLableWithFrame:CGRectMake(leftMargin, (viewHeight - labelHeight) / 2, inquiryServiceLabelWidth, labelHeight) font:kSystemFitFont(15) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [inquiryServiceView addSubview:inquiryServiceLabel];
    inquiryServiceLabel.text = inquiryServiceStr;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight, kScreenWidth, 0.5)];
    lineView.backgroundColor = RGB_COLOR_WITH_0x(kCellLineViewColor);
    [inquiryServiceView addSubview:lineView];
    
    CGFloat leftGapMargin = KFloat(12);
    CGFloat inquiryServiceTipViewWidth = inquiryServiceView.width - leftGapMargin * 2;
    UIView *inquiryServiceTipView = [[UIView alloc] initWithFrame:CGRectMake(leftGapMargin, UIViewBottomY(lineView) + leftGapMargin, inquiryServiceTipViewWidth, 0)];
    inquiryServiceTipView.backgroundColor = RGB_COLOR_WITH_0x(0xf2f9fe);
    [inquiryServiceView addSubview:inquiryServiceTipView];
    
    UILabel *uploadTipLabel = [UIViewUtil creatLableWithFrame:CGRectMake(0, KFloat(15), inquiryServiceTipViewWidth, KFloat(15)) font:kSystemFitFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(0xe96f2d)];
    [inquiryServiceTipView addSubview:uploadTipLabel];
    uploadTipLabel.text = @"   *  照片必须包含以下内容，可上传3张";
    
    NSString *uploadInfoTipStr = @"患者信息： 姓名 性别 年龄\n处方信息： 疾病诊断 药品用法用量\n地址信息： 地址 收件人 电话";
    CGFloat uploadInfoTipHeight = [uploadInfoTipStr getStringSizeWithFont:kSystemFitFont(14) constrainedToSize:CGSizeMake(inquiryServiceTipViewWidth, MAXFLOAT)].height;
    UILabel *uploadInfoTipLabel = [UIViewUtil creatLableWithFrame:CGRectMake(0, UIViewBottomY(uploadTipLabel) + KFloat(15.5), inquiryServiceTipViewWidth, uploadInfoTipHeight) font:kSystemFitFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    uploadInfoTipLabel.numberOfLines = 0;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:uploadInfoTipStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [uploadInfoTipStr length])];
    [uploadInfoTipLabel setAttributedText:attributedString1];
    [inquiryServiceTipView addSubview:uploadInfoTipLabel];
    [uploadInfoTipLabel sizeToFit];
    uploadInfoTipLabel.centerX = inquiryServiceTipView.centerX;
    
    
    inquiryServiceTipView.height = UIViewBottomY(uploadInfoTipLabel) + KFloat(15);
    
    CGFloat pictureBJViewHeight = (inquiryServiceView.width - leftGapMargin * 2 - KFloat(6) * 3) / 4;
    FilmPrescriptionView *pictureBJView = [[FilmPrescriptionView alloc] initWithFrame:CGRectMake(leftGapMargin, UIViewBottomY(inquiryServiceTipView) + leftGapMargin, inquiryServiceView.width - leftGapMargin * 2, pictureBJViewHeight)];
    pictureBJView.imageUrl = @"http://img.yanj.cn/store/goods/3488/3488_909a42564c7d2806ef3f87c4c5fe6029.jpg_max.jpg";
    [inquiryServiceView addSubview:pictureBJView];
    self.filmPresctiptionView = pictureBJView;
    WS(weakSelf);
    pictureBJView.widthBlock = ^(CGFloat currentViewWidth) {
        weakSelf.filmPresctiptionView.width = currentViewWidth;
        weakSelf.filmPresctiptionView.centerX = inquiryServiceView.centerX;
    };
    pictureBJView.block = ^(NSArray * _Nonnull selectedPhotos) {
        DEBUG_LOG(@"%@", selectedPhotos);
    };
    
    inquiryServiceView.height = UIViewBottomY(pictureBJView) + KFloat(15);
    
    //3.诊费
    UIView *inquiryFeeView = [[UIView alloc] initWithFrame:CGRectMake(0, UIViewBottomY(inquiryServiceView) + spacing, kScreenWidth, viewHeight)];
    inquiryFeeView.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
    [self addSubview:inquiryFeeView];
    self.inquiryFeeView = inquiryFeeView;
    
    NSString *inquiryFeeStr = @"诊费";
    CGFloat inquiryFeeLabelWidth = [self calculatlabelWidthValue:inquiryFeeStr labelHeight:labelHeight font:kSystemFitFont(15)];
    UILabel *inquiryFeeLabel = [UIViewUtil creatLableWithFrame:CGRectMake(leftMargin, (viewHeight - labelHeight) / 2, inquiryFeeLabelWidth, labelHeight) font:kSystemFitFont(15) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [inquiryFeeView addSubview:inquiryFeeLabel];
    inquiryFeeLabel.text = inquiryFeeStr;
    
    CGFloat inquiryFeeTFWidth = inquiryFeeView.width - leftMargin * (2 + 1) - inquiryFeeLabel.width;
    UITextField *inquiryFeeTF = [[UITextField alloc] initWithFrame:CGRectMake(0, inquiryFeeLabel.top, inquiryFeeTFWidth, labelHeight)];
    inquiryFeeTF.font = kSystemFitFont(15);
    inquiryFeeTF.textAlignment = NSTextAlignmentRight;
    inquiryFeeTF.textColor = RGB_COLOR_WITH_0x(kBlackTextColor);
    inquiryFeeTF.placeholder = @"请输入诊费";
    [inquiryFeeView addSubview:inquiryFeeTF];
    inquiryFeeTF.right = inquiryFeeView.right - leftMargin;
    
    //4.用法用量
    UIView *medicalUseView = [[UIView alloc] initWithFrame:CGRectMake(0, UIViewBottomY(inquiryFeeView) + spacing, kScreenWidth, viewHeight)];
    medicalUseView.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
    [self addSubview:medicalUseView];
    self.medicalUseView = medicalUseView;
    
    NSString *medicalUseStr = @"用法用量";
    CGFloat medicalUseLabelWidth = [self calculatlabelWidthValue:medicalUseStr labelHeight:labelHeight font:kSystemFitFont(15)];
    UILabel *medicalUseLabel = [UIViewUtil creatLableWithFrame:CGRectMake(leftMargin, (viewHeight - labelHeight) / 2, medicalUseLabelWidth, labelHeight) font:kSystemFitFont(15) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [medicalUseView addSubview:medicalUseLabel];
    medicalUseLabel.text = medicalUseStr;
    
    
    CGFloat medicalUseTFWidth = medicalUseView.width - leftMargin * (2 + 1) - medicalUseLabel.width;
    UITextField *medicalUseTF = [[UITextField alloc] initWithFrame:CGRectMake(0, medicalUseLabel.top, medicalUseTFWidth, labelHeight)];
    medicalUseTF.font = kSystemFitFont(15);
    medicalUseTF.textAlignment = NSTextAlignmentRight;
    medicalUseTF.textColor = RGB_COLOR_WITH_0x(kBlackTextColor);
    medicalUseTF.placeholder = @"备注好药品用法用量";
    [medicalUseView addSubview:medicalUseTF];
    medicalUseTF.right = medicalUseView.right - leftMargin;
    
    //5.提示信息
    UIView *infoTipView = [[UIView alloc] initWithFrame:CGRectMake(0, UIViewBottomY(medicalUseView) + spacing, kScreenWidth, 0)];
    [self addSubview:infoTipView];
    NSArray *titleArray = @[@"* 互联网诊疗仅适用于常见疾病、慢性病复诊，且必须掌握患者病历，以及实体医疗结构诊断证明不对患者做首诊、急诊患者在线开方、诊疗。",@"* 上传处方照片高度清晰，如手写处方需自己清晰以便医务人员确认。",@"* 同一处方只能上传一次，如果出现多次上传，以最后一次上传为准。",@"* 订单满79元包邮，不足79元将产生6元运费。"];
    CGFloat Y = leftMargin;
    CGFloat infoTipLabelWidth = kScreenWidth - leftMargin * 2;
    UIFont *font14 = kSystemFitFont(14);
    CGFloat gapHeight = KFloat(10);
    NSInteger tempCount = titleArray.count;
    for (NSInteger i = 0; i < tempCount; i++) {
        CGFloat infoTipLabelHeight = [titleArray[i] getStringSizeWithFont:font14 constrainedToSize:CGSizeMake(infoTipLabelWidth, MAXFLOAT)].height;
        UILabel *infoTipLabel = [UIViewUtil creatLableWithFrame:CGRectMake(leftMargin, Y, infoTipLabelWidth, infoTipLabelHeight) font:font14 textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
        infoTipLabel.numberOfLines = 0;
        infoTipLabel.tag = 10 + i;
        infoTipLabel.text = titleArray[i];
        [infoTipView addSubview:infoTipLabel];
        infoTipLabel.attributedText = [infoTipLabel.text setAttributedWithIdentifyString:@"*" color:RGB_COLOR_WITH_0x(0xe96f2d)];
        Y = UIViewBottomY(infoTipLabel) + gapHeight;
    }
    UILabel *postalInforLabel = (UILabel *)[infoTipView viewWithTag:(10 + tempCount - 1)];
    postalInforLabel.textColor = RGB_COLOR_WITH_0x(0xe96f2d);
    
    infoTipView.height = Y;
    self.submitButtonView.frame = CGRectMake(0, UIViewBottomY(infoTipView) + spacing, kScreenWidth, FooterButtonViewFactsHeight);
    self.contentSize = CGSizeMake(kScreenWidth, UIViewBottomY(self.submitButtonView));
    
}

- (CGFloat)calculatlabelWidthValue:(NSString *)content labelHeight:(CGFloat)labelHeight font:(UIFont *)font{
    CGFloat labelWidth = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    return labelWidth;
}


-(UIView *)submitButtonView{
    if (!_submitButtonView) {
        _submitButtonView = [[FooterButtonView alloc]initWithFrame:CGRectZero];
        _submitButtonView.backgroundColor = [UIColor clearColor];
        [self addSubview:_submitButtonView];
        CGFloat X = KFloat(15);
        CGFloat height = FooterButtonViewHeight;
        CGFloat buttonHeight = FooterButtonHeight;
        CGFloat Y = (height-buttonHeight)/2;
        UIButton *button = [UIViewUtil creatButtonWithFrame:CGRectMake(X, Y, kScreenWidth - X * 2, buttonHeight) font:kSystemFitFont(15) title:@"提交处方" titleColor:RGB_COLOR_WITH_0x(kWhiteColor) bgNormalImage:nil bgHightLightImage:nil];
        button.backgroundColor = RGB_COLOR_WITH_0x(kDocBlueColor);
        button.layer.cornerRadius = buttonHeight/2;
        [button addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_submitButtonView addSubview:button];
    }
    return _submitButtonView;
}

- (void)submitBtnClick{
    DEBUG_LOG(@"点击了提交处方");
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.block) {
        self.block(dic);
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
//    NSDictionary *userInfo = [notification userInfo];
//    NSValue* value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [value CGRectValue]; // 这里得到了键盘的frame
    
//    __weak typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.23 animations:^{
//        weakSelf.inquiryFeeView.y = kScreenHeight-keyboardRect.size.height;
//        weakSelf.medicalUseView.y = kScreenHeight-keyboardRect.size.height;
//    } completion:^(BOOL finished) {
//        if (weakSelf.contentSize.height>=kScreenHeight+keyboardRect.size.height) {
//            weakSelf.height = kScreenHeight-keyboardRect.size.height;
//        }
//    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // 获取info同上面的方法
    // 你的操作，如键盘移除，控制视图还原等
    // 动画
//    __weak typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.23 animations:^{
//        weakSelf.height = kScreenHeight;
//        weakSelf.medicalUseView.y = kScreenHeight;
//    } completion:^(BOOL finished) {
//
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
