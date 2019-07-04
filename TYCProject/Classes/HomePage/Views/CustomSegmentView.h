//
//  CustomSegmentView.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/4/9.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomSegmentView : UIView

- (instancetype)initWithItemTitles:(NSArray *)itemTitles;

/**
 *  从0开始
 */
@property (nonatomic,copy) void (^customSegmentViewBtnClickHandle)(CustomSegmentView *segment, NSString *currentTitle, NSInteger currentIndex);

- (void)clickDefault;
- (void)clickDefault1;

- (void)clickDefaultIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
