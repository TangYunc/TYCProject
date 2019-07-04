//
//  SectionModel.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/18.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel

-(CGFloat)cellHeight{
    if (!_cellHeight) {
        UIImage *addressIcon = [UIImage imageNamed:@"icon_dz"];
        CGFloat adressWidth = kScreenWidth - KFloat(15) - KFloat(10) - addressIcon.size.width;
        CGFloat addressHeight = [_address calculatlabelWidthLabelWidth:adressWidth labelHeight:0 font:kSystemFitFont(14) isWidth:NO].height;
        _cellHeight = KFloat(15) * 7 + KFloat(14) * 8 + KFloat(10) * 2 + KFloat(18) * 2 + KFloat(20) * 5 + KFloat(30) + 0.5 + addressHeight;
    }
    return _cellHeight;
}

@end
