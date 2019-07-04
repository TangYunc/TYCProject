//
//  FilmPrescriptionUploadDetailStatuCell.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionUploadDetailStatuCell.h"

@interface FilmPrescriptionUploadDetailStatuCell ()
{
    UILabel *_hospatilLabel;
    UILabel *_statuLabel;
}
@end

@implementation FilmPrescriptionUploadDetailStatuCell

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
    
    //名字
    _hospatilLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(16) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:_hospatilLabel];
    
    //认证状态
    _statuLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(12) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(0xe96f2d)];
    _statuLabel.layer.borderColor = RGB_COLOR_WITH_0x(0xe96f2d).CGColor;
    _statuLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:_statuLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSString *hospatilName = @"银川妙手互联网医院";
    CGFloat hospatilLabelHeight = KFloat(16);
    
    CGFloat hospatilLabelWidth = [hospatilName calculatlabelWidthLabelWidth:0 labelHeight:hospatilLabelHeight font:kSystemFitBordFont(16) isWidth:YES].width;
    CGFloat topMargin = (self.frame.size.height - hospatilLabelHeight) / 2;
    CGFloat leftMargin = (self.frame.size.width - hospatilLabelWidth) / 2;
    _hospatilLabel.frame = CGRectMake(leftMargin, topMargin, hospatilLabelWidth, hospatilLabelHeight);
    _hospatilLabel.text = hospatilName;
    
    NSString *statusStr = @"已审核";
    _statuLabel.frame = CGRectMake(0, 0, KFloat(70), hospatilLabelHeight + KFloat(10));
    _statuLabel.layer.cornerRadius = _statuLabel.height / 2;
    _statuLabel.text = statusStr;
    _statuLabel.centerY = _hospatilLabel.centerY;
    _statuLabel.right = self.width - KFloat(15);
}

@end


@interface FilmPrescriptionUploadDetailCheckCell ()
{
    UILabel *_titleLabel;
}
@end

@implementation FilmPrescriptionUploadDetailCheckCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundView = nil;
        //名字
        _titleLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitBordFont(14) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
        NSString *titleName = @"查看处方 >";
        [self.contentView addSubview:_titleLabel];
        _titleLabel.text = titleName;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
    
}
@end
