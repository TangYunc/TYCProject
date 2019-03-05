//
//  BaseCell.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/25.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bottomLine = [[UIView alloc]init];
        self.bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
        self.bottomLine.backgroundColor = RGB_COLOR_WITH_0x(kCellLineViewColor);
        [self addSubview:self.bottomLine];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[line]-0-|",KFloat(15)] options:0 metrics:nil views:@{@"line":self.bottomLine}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(0.5)]-0-|" options:0 metrics:nil views:@{@"line":self.bottomLine}]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
