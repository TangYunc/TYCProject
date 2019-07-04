//
//  CustomSegmentView.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/4/9.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "CustomSegmentView.h"

@implementation CustomSegmentView
{
    NSArray *_itemTitles;
    UIButton *_selectedBtn;
}

- (instancetype)initWithItemTitles:(NSArray *)itemTitles{
    if (self = [super init]) {
        _itemTitles = itemTitles;
        [self setUpViews];
    }
    return self;
}


- (void)setUpViews {
    
    if (_itemTitles.count > 0) {
        NSInteger i = 0;
        for (id obj in _itemTitles) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *objStr = (NSString *)obj;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:btn];
                btn.backgroundColor = [UIColor clearColor];
                [btn setTitle:objStr forState:UIControlStateNormal];
                [btn setTitleColor:UIColorFromRGBA(50, 50, 50, 1.0) forState:UIControlStateSelected];
                [btn setTitleColor:UIColorFromRGBA(153, 153, 153, 1.0) forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
                i = i + 1;
                btn.tag = i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.adjustsImageWhenDisabled = NO;
                btn.adjustsImageWhenHighlighted = NO;
            }
        }
    }
}

- (void)btnClick:(UIButton *)btn {
    
    
    _selectedBtn.backgroundColor = [UIColor clearColor];
    btn.backgroundColor = [UIColor clearColor];
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    NSString *title = btn.currentTitle;
    if (self.customSegmentViewBtnClickHandle) {
        self.customSegmentViewBtnClickHandle(self, title, btn.tag - 1);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_itemTitles.count > 0) {
        CGFloat btnW = self.width / _itemTitles.count;
        for (int i = 0 ; i < _itemTitles.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i + 1];
            btn.frame = CGRectMake(btnW * i, 0, btnW, self.height);
        }
    }
}

- (void)clickDefault1 {
    if (_itemTitles.count == 1) {
        return ;
    }
    [self btnClick:(UIButton *)[self viewWithTag:1]];
}
- (void)clickDefault {
    if (_itemTitles.count == 0) {
        return ;
    }
    [self btnClick:(UIButton *)[self viewWithTag:2]];
}

- (void)clickDefaultIndex:(NSInteger)index {
    if (_itemTitles.count == 0) {
        return ;
    }
    [self btnClick:(UIButton *)[self viewWithTag:index]];
}

@end
