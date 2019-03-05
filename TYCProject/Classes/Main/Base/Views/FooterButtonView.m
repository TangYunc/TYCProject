//
//  FooterButtonView.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/25.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "FooterButtonView.h"

@implementation FooterButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
        self.layer.shadowOffset = CGSizeMake(0, -1);
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowColor = RGB_COLOR_WITH_0x(kShadowColor).CGColor;
    }
    return self;
}

@end
