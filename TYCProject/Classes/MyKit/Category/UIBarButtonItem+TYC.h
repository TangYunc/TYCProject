//
//  UIBarButtonItem+TYC.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/3/5.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (TYC)

+(instancetype)itemWithNorImage:(NSString *)norImageName higImage:(NSString *)higImageName targe:(id)targe action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
