//
//  PrescriptionBuyDrugBottomAlertView.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/25.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "PrescriptionBuyDrugBottomAlertView.h"

@implementation PrescriptionBuyDrugBottomAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat margin = KFloat(10);
        UILabel *label = [UIViewUtil creatLableWithFrame:CGRectMake(margin, margin, kScreenWidth-margin*2, PrescriptionBuyDrugBottomAlertHeight-margin*2) font:kSystemFitFont(12) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(kBlackText999Color)];
        label.numberOfLines = 0;
        label.text = @"备注: 本处方当3天内有效,药师审方后,\n请到指定的药房够药.";
        label.tag = 10;
        [self addSubview:label];
    }
    return self;
}

- (void)setTipInfo:(NSString *)tipInfo{
    _tipInfo = tipInfo;
    UILabel *label = (UILabel *)[self viewWithTag:10];
    label.text = tipInfo;
}

@end
