//
//  FooterButtonView.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/25.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define FooterButtonViewHeight (KFloat(55))
#define FooterButtonHeight (KFloat(44))
#define FooterButtonViewFactsHeight (FooterButtonViewHeight+SafeAreaBottomHeight)

#define FooterButtonColor RGB_COLOR_WITH_0x(0x4679f8)
#define FooterButtonTitleColor RGB_COLOR_WITH_0x(kWhiteColor)
#define FooterButtonFont kSystemFitFont(15)

@interface FooterButtonView : UIView

@end

NS_ASSUME_NONNULL_END
