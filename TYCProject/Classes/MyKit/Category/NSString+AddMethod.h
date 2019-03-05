//
//  NSString+AddMethod.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/21.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AddMethod)
//********************************************文本加密*****************************************************//
/**
 对字符串进行MD5加密

 @return 加密字符串
 */
- (NSString *) stringFromMD5;


//********************************************文本校验*****************************************************//
/**
 *  手机号码的正则校验
 *
 */
-(BOOL) validateMobile;
/**
 *  邮箱的正则校验
 *
 *
 */
- (BOOL) validateEmail;
/**
 电话号的星号加密
 
 电话号码:12344556667(string:123****6667)
 @return 返回加密的电话号码
 */
-(NSString *)changeTelephone;


//********************************************文本判空*****************************************************//
+ (BOOL)isBlankString:(NSString *)string;

//********************************************移除空格和回车 以及特殊的字符串*****************************************************//
+(NSString*)stringRemoveSpaceAndEnterWith:(NSString *)string;

+(BOOL)validateStringWithString:(NSString *)string;

/** 移除输入中文的时候两个字母之间的字符串*/
-(NSString *)stringRemoveChinaInputUnicode;


//********************************************文本URL*****************************************************//
- (NSString *)URLEncodedString;

- (NSString *)URLDecodedString;


//********************************************富文本*****************************************************//
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString font:(UIFont *)font;
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color font:(UIFont *)font;

// 传递一个字符串数组，可以染不同的颜色，后期有需要可以把 color 和 font 也已数组的形式传递，配对使用
-(NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font;

// 获取行间距类型
+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing font:(UIFont *)font;
// 获取行间距类型
+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment font:(UIFont *)font;


//********************************************文本尺寸*****************************************************//
-(CGSize)getStringSizeWithFont:(UIFont *)font;
+(CGSize)getStringSizeWithFont:(UIFont *)font;

-(CGSize)getStringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size;
-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute;
+(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size;

/**
 计算宽高

 @param labelWidth 文本内容约束宽度
 @param labelHeight 文本内容约束高度
 @param font 文本内容约束字体大小
 @param isWidth 是否是求宽度。YES求宽，NO求高
 @return CGSize
 */
- (CGSize)calculatlabelWidthLabelWidth:(CGFloat)labelWidth labelHeight:(CGFloat)labelHeight font:(UIFont *)font isWidth:(BOOL)isWidth;

@end

NS_ASSUME_NONNULL_END
