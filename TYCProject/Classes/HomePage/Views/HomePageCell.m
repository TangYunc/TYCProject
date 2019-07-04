//
//  HomePageCell.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/3/28.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "HomePageCell.h"

@interface HomePageCell ()
{
    UILabel *_titleLabel;
}
@end

@implementation HomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor cyanColor];
        self.backgroundView = nil;
        //初始化子视图
        [self initSubviews];
    }
    return self;
}


//初始化子视图
- (void)initSubviews{
    
    //名字
    CGFloat leftGap = KFloat(17);
    CGFloat titleLabelHeight = kSystemFitFontHeight(17);
    _titleLabel = [UIViewUtil creatLableWithFrame:CGRectZero font:kSystemFitFont(17) textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    [self.contentView addSubview:_titleLabel];
    CGFloat titleLabelWidth = kScreenWidth - leftGap * 2 - KFloat(11) - leftGap;
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftGap);
        make.size.mas_equalTo(CGSizeMake(titleLabelWidth, titleLabelHeight));
        make.centerY.equalTo(weakSelf);
    }];
    
}


- (void)setTheDic:(NSDictionary *)theDic{
    _theDic = theDic;
    NSString *titleStr = self.theDic[@"title"];
    _titleLabel.text = titleStr;
}

@end
