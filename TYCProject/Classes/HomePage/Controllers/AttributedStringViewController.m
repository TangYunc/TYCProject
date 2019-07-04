//
//  AttributedStringViewController.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/3/28.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "AttributedStringViewController.h"

@interface AttributedStringViewController ()<TYCAttributeTapActionDelegate>

@end

@implementation AttributedStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];

}

- (void)setupSubviews{
    CGFloat leftMargin = KFloat(15);
    CGFloat topMargin = KFloat(30);
    CGFloat viewSpacing = KFloat(40);
    NSString *content = @"云来雾去川流不息等伊人，云过天空川身而过终无缘，www.baidu.com";
    NSArray *changeStrArr = @[@"云", @"川", @"伊人"];
    UIFont *labelFont = kSystemFitFont(18);
    CGFloat labelWidth = self.view.width - leftMargin * 2;
    CGFloat labelHeigth = [content calculatlabelWidthLabelWidth:labelWidth labelHeight:0 font:labelFont isWidth:NO].height;;
    
    
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *label = [UIViewUtil creatLableWithFrame:CGRectMake(30, topMargin + i * (labelHeigth + viewSpacing), labelWidth, labelHeigth) font:labelFont textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
        label.numberOfLines = 0;
        label.text = content;
        label.tag = 100 + i;
        [self.view addSubview:label];
    }
    UILabel *label1 = (UILabel *)[self.view viewWithTag:100];
    label1.userInteractionEnabled = YES;
    NSAttributedString *attributedStr1 = [content setAttributedWithIdentifyStringArray:@[@"www.baidu.com"] color:[UIColor magentaColor] font:kSystemFitFont(18)];
    [label1 tyc_addAttributeTapActionWithStrings:@[@"www.baidu.com"] delegate:self];
//    [label1 tyc_addAttributeTapActionWithStrings:@[@"www.baidu.com"] tapClicked:^(NSString * _Nonnull string, NSRange range, NSInteger index) {
//        DEBUG_LOG(@"currentString:%@", string);
//    }];
    label1.attributedText = attributedStr1;
    
    UILabel *label2 = (UILabel *)[self.view viewWithTag:101];
    NSAttributedString *attributedStr2 = [content setAttributedWithIdentifyStringArray:changeStrArr color:[UIColor orangeColor] font:kSystemFitFont(14)];
    label2.attributedText = attributedStr2;
    
    
    NSArray *colorArr = @[[UIColor yellowColor], [UIColor greenColor]];
    NSArray *fontArr = @[@(9), @(16)];
    UILabel *label4 = (UILabel *)[self.view viewWithTag:103];
    NSAttributedString *attributedStr3 = [NSString changeTextContent:content stringArray:@[@"云来雾去", @"天空川身而过终无缘"] colorArray:colorArr fontArray:fontArr];
    label4.attributedText = attributedStr3;
    
    
    UILabel *label5 = (UILabel *)[self.view viewWithTag:104];
    NSAttributedString *attributedStr5 = [content setAttributedWithIdentifyString:@"终无缘" color:[UIColor cyanColor]];
    label5.attributedText = attributedStr5;
    
    [self setupLabel];
}

- (void)setupLabel{
    
    UILabel *label5 = (UILabel *)[self.view viewWithTag:104];
    CGFloat leftMargin = KFloat(15);
    CGFloat topMargin = KFloat(30);
    UIFont *labelFont = kSystemFitFont(18);
    NSString *titleStr = @"王亚好不好看，是个大凑逼。这个必须置顶，哈哈哈哈哈哈";
    CGFloat labelWidth = self.view.width - leftMargin * 2;
    
//    CGFloat labelHeigth = [titleStr calculatlabelWidthLabelWidth:labelWidth labelHeight:0 font:labelFont isWidth:NO].height;
    UILabel *label = [UIViewUtil creatLableWithFrame:CGRectZero font:labelFont textAlignment:NSTextAlignmentLeft textColor:RGB_COLOR_WITH_0x(kBlackTextColor)];
    CGSize titleLabelWidthSize = [label sizeThatFits:CGSizeMake(labelWidth,MAXFLOAT)];
    label.frame = CGRectMake(leftMargin, label5.bottom + topMargin, labelWidth, titleLabelWidthSize.height);
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    NSString *zhiDingStr = @"# 置顶";
    CGFloat zhiDingStrWidth = [zhiDingStr calculatlabelWidthLabelWidth:0 labelHeight:18 font:labelFont isWidth:YES].width;
    UILabel *theSpecialLabel = [[UILabel alloc] init];
    theSpecialLabel.layer.borderWidth = 1;
    theSpecialLabel.layer.borderColor = UIColorFromRGBA(255, 78, 78, 1.0).CGColor;
    theSpecialLabel.layer.cornerRadius = 2;
    theSpecialLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    theSpecialLabel.font = [UIFont systemFontOfSize:10.f];
    theSpecialLabel.textAlignment = NSTextAlignmentCenter;
    theSpecialLabel.textColor = UIColorFromRGBA(255, 78, 78, 1.0);
    theSpecialLabel.bounds = CGRectMake(0, 0, zhiDingStrWidth, 18);
    theSpecialLabel.text = zhiDingStr;
    UIImage *theSpecialImage = [self imageWithUIView:theSpecialLabel];
    //设置Attachment
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    if (zhiDingStr == nil) {
        //非置顶商品
        attachment.image = nil;
    }else{
        //置顶商品
        //使用一张图片作为Attachment数据
        attachment.image = theSpecialImage;
    }
    //这里bounds的x值并不会产生影响
    attachment.bounds = CGRectMake(0, -3, attachment.image.size.width, attachment.image.size.height);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",titleStr]];
    [attributedString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    label.attributedText = attributedString;
    [label sizeToFit];
}


//视图转换为UILabel
- (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    //    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

#pragma mark -- TYCAttributeTapActionDelegate
- (void)tyc_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index{
    DEBUG_LOG(@"currentString:%@", string);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
