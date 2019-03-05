//
//  YXAlertView.m
//  Doctor
//
//  Created by 张良玉 on 16/12/1.
//  Copyright © 2016年 YX. All rights reserved.
//

#import "YXAlertView.h"
@interface YXAlertView ()<UIAlertViewDelegate>
@property (nonatomic ,weak) id<YXAlertViewDelegate> alertViewDelegate;
@property (nonatomic ,strong) id object;
@property (nonatomic ,strong) void(^clickedBlock)(NSInteger buttonIndex);
@end

@implementation YXAlertView

+(void) shareAlerViewWithTitle:(NSString *)title message:(NSString *)message tag:(NSInteger)tag delegate:(nullable id<YXAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    YXAlertView *alertView = [[YXAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
    alertView.tag = tag;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message tag:(NSInteger)tag delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle object:(nullable id)object
{
    YXAlertView *alertView = [[YXAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
    alertView.tag = tag;
    alertView.object = object;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle clickedBlock:(void(^)(NSInteger buttonIndex))clickedBlock{
    YXAlertView *alertView = [[YXAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
    alertView.clickedBlock = clickedBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    self = [super init];
    if (self) {
        self.alertViewDelegate = delegate;
        if (!isIOS8) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:cancelButtonTitle,otherButtonTitle, nil];
            [alertView show];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            __weak __typeof(self) weakSelf = self;
            if (cancelButtonTitle) {
                NSString *cancelButton = NSLocalizedString(cancelButtonTitle, nil);
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [weakSelf clickedButtonAtIndex:0];
                }];
                [alertController addAction:cancelAction];
            }
            if (otherButtonTitle) {
                NSString *otherButton = NSLocalizedString(otherButtonTitle, nil);
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [weakSelf clickedButtonAtIndex:1];
                }];
                [alertController addAction:otherAction];
            }
            
            UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UIViewController *viewController = [tabBarController.viewControllers firstObject];
            [viewController presentViewController:alertController animated:YES completion:nil];
        }

    }
    return self;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self clickedButtonAtIndex:buttonIndex];
}

-(void)clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.clickedBlock) {
        self.clickedBlock(buttonIndex);
    }
    if ([self.alertViewDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.alertViewDelegate alertView:self clickedButtonAtIndex:buttonIndex];
    }
    if ([self.alertViewDelegate respondsToSelector:@selector(alertView:object:clickedButtonAtIndex:)]) {
        [self.alertViewDelegate alertView:self object:self.object clickedButtonAtIndex:buttonIndex];
    }
    [self removeFromSuperview];
}

+(void) shareAlerViewWithTitle:(NSString *)title message:(NSString *)message textAlignment:(NSTextAlignment)textAlignment tag:(NSInteger)tag delegate:(id<YXAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    [YXAlertView shareAlerViewWithTitle:title message:message textAlignment:textAlignment tag:tag delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle object:nil];
}

+(void) shareAlerViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message textAlignment:(NSTextAlignment )textAlignment tag:(NSInteger)tag delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle object:(nullable id)object{
    YXAlertView * alertView = [[YXAlertView alloc]initWithTitle:title message:message textAlignment:textAlignment delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
    alertView.tag = tag;
    alertView.object = object;
}
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message textAlignment:(NSTextAlignment )textAlignment delegate:(nullable id<YXAlertViewDelegate>)delegate  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    self = [super init];
    if (self) {
        if ((title && ![title isEqualToString:@""])||(message && ![message isEqualToString:@""])) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            CGSize winSize = window.bounds.size;
            self.frame = CGRectMake(0, 0, winSize.width, winSize.height);
            self.backgroundColor = RGB_COLOR_WITH_0x_alpha(0x000000, 0.5);
            [window addSubview:self];
            
            self.alertViewDelegate = delegate;
            
            UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, winSize.width-KFloat(50)*2, 100)];
            showView.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
            showView.layer.cornerRadius = 10;
            showView.layer.masksToBounds = YES;
            [self addSubview:showView];
            CGFloat Y = KFloat(15);
            if (title && ![title isEqualToString:@""]) {
                CGFloat width = showView.width-2*KFloat(15);
                CGSize size = [title getStringSizeWithFont:kSystemFitBordFont(18) constrainedToSize:CGSizeMake(width, MAXFLOAT)];
                UILabel *titleLabel = [UIViewUtil creatLableWithFrame:CGRectMake(KFloat(15), Y, width, size.height) font:kSystemFitBordFont(18) textAlignment:NSTextAlignmentCenter textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
                titleLabel.numberOfLines = 0;
                titleLabel.text = title;
                [showView addSubview:titleLabel];
                Y = KFloat(10)+UIViewBottomY(titleLabel);
            }
            if (message && ![message isEqualToString:@""]) {
                CGFloat width = showView.width-2*KFloat(15);
                CGSize size = [message getStringSizeWithFont:kSystemFitFont(16) constrainedToSize:CGSizeMake(width, MAXFLOAT)];
                UILabel *messageLabel = [UIViewUtil creatLableWithFrame:CGRectMake(KFloat(15), Y, width, size.height) font:kSystemFitFont(16) textAlignment:textAlignment textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
                messageLabel.numberOfLines = 0;
                messageLabel.text = message;
                [showView addSubview:messageLabel];
                Y = UIViewBottomY(messageLabel);
            }
            NSMutableArray *buttons = [NSMutableArray array];
            if (cancelButtonTitle && ![cancelButtonTitle isEqualToString:@""]) {
                UIButton *buttn = [[UIButton alloc]init];
                [buttn setTitle:cancelButtonTitle forState:UIControlStateNormal];
                buttn.tag = 0;
                [buttons addObject:buttn];
            }
            if (otherButtonTitle && ![otherButtonTitle isEqualToString:@""]) {
                UIButton *buttn = [[UIButton alloc]init];
                [buttn setTitle:otherButtonTitle forState:UIControlStateNormal];
                buttn.tag = 1;
                [buttons addObject:buttn];
            }
            if (buttons.count) {
                Y += KFloat(10);
                UIView *hLineView = [[UIView alloc]initWithFrame:CGRectMake(0, Y, showView.width, 0.5)];
                hLineView.backgroundColor = RGB_COLOR_WITH_0x(kCellLineViewColor);
                [showView addSubview:hLineView];
                Y = UIViewBottomY(hLineView);
                
                CGFloat width = showView.width/buttons.count;
                for (int i=0; i<buttons.count; i++) {
                    UIButton *button = buttons[i];
                    button.frame = CGRectMake(0+i*width, Y, width, KFloat(44));
                    [button setTitleColor:RGB_COLOR_WITH_0x(kDocBlueColor) forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    [showView addSubview:button];
                    if (i-1>=0) {
                        UIView *vLineView = [[UIView alloc]initWithFrame:CGRectMake(showView.width/2, Y, 0.5, KFloat(44))];
                        vLineView.backgroundColor = RGB_COLOR_WITH_0x(kCellLineViewColor);
                        [showView addSubview:vLineView];
                        vLineView.centerX = showView.centerX;
                    }
                }
                Y += KFloat(44);
            }else{
                Y += KFloat(15);
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
                [self addGestureRecognizer:tapGesture];
            }
            showView.height = Y;
            showView.center = self.center;
        }
    }
    return self;
}

-(void) buttonClick:(UIButton *)button
{
    [self clickedButtonAtIndex:button.tag];
}

-(void)tapGesture{
    [self clickedButtonAtIndex:0];
}
@end
