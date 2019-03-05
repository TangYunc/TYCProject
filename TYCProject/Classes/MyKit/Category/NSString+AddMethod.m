//
//  NSString+AddMethod.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/21.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "NSString+AddMethod.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (AddMethod)

//********************************************文本加密*****************************************************//
- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    //    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}


//********************************************文本校验*****************************************************//
-(BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)validateMobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //手机号以13， 15，18，17，14开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(14[0,0-9])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

-(NSString *)changeTelephone{
    
    NSString *string = [self stringByReplacingOccurrencesOfString:[self substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
    return string;
}


//********************************************文本判空*****************************************************//
+ (BOOL)isBlankString:(NSString *)string{
    
    //字符串的长度为0表示空串
    if (string.length == 0) {
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


//********************************************移除空格和回车 以及特殊的字符串*****************************************************//
+(NSString *)stringRemoveSpaceAndEnterWith:(NSString *)string{
    string= [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string =[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string =[string stringByReplacingOccurrencesOfString:@"/r" withString:@""];
    string=[string stringByReplacingOccurrencesOfString:@"'/n'" withString:@""];
    return string;
}

+(BOOL)validateStringWithString:(NSString *)string{
    if (string==nil||string.length==0) {
        return NO;
    }
    string= [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *text1 =[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    text1 =[text1 stringByReplacingOccurrencesOfString:@"/r" withString:@""];
    NSString *finalText=[text1 stringByReplacingOccurrencesOfString:@"'/n'" withString:@""];
    
    if (finalText.length==0) {
        return NO;
    }else{
        return  YES;
    }
}

-(NSString *)stringRemoveChinaInputUnicode{
    unichar ch[1]={0x2006};
    NSString *unicode=[NSString stringWithCharacters:ch length:1];
    NSString *keyword=[self stringByReplacingOccurrencesOfString:unicode withString:@""];
    return keyword;
}


//********************************************文本URL*****************************************************//
- (NSString *)URLEncodedString{
    NSString *charactersToEscape = @"#[]@!$'()*+,;\"<>%{}|^~`";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedString = [[self description] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedString;
}

- (NSString*)URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}


//********************************************富文本*****************************************************//
-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color{
    return [self setAttributedWithIdentifyString:identifyString color:color font:nil];
}

-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing{
    return [self setAttributedWithIdentifyString:identifyString color:color lineSpacing:lineSpacing alignment:NSTextAlignmentLeft];
}

-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment{
    if (!self&&!identifyString) {
        return nil;
    }
    NSString *panString = self?self:identifyString;
    identifyString = identifyString?identifyString:@"";
    
    NSRange range = [panString rangeOfString:identifyString];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:panString];
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (lineSpacing) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.lineSpacing = lineSpacing;
        paraStyle.alignment = alignment;
        [attributedStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, self.length)];
    }
    return attributedStr;
}

-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString font:(UIFont *)font{
    return [self setAttributedWithIdentifyString:identifyString color:nil font:font];
}

-(NSMutableAttributedString *)setAttributedWithIdentifyString:(NSString *)identifyString color:(UIColor *)color font:(UIFont *)font{
    if (!self&&!identifyString) {
        return nil;
    }
    NSString *panString = self?self:identifyString;
    identifyString = identifyString?identifyString:@"";
    
    NSRange range = [panString rangeOfString:identifyString];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:panString];
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
    return attributedStr;
}

- (NSMutableAttributedString *)setAttributedWithIdentifyStringArray:(NSArray *)identifyStringArray color:(UIColor *)color font:(UIFont *)font{
    if (!self&&!identifyStringArray) {
        return nil;
    }
    if (!identifyStringArray.count) {
        return nil;
    }
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    for (NSString *identifyString in identifyStringArray) {
        NSRange range = [self rangeOfString:identifyString];
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    return attributedStr;
}

+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing font:(UIFont *)font{
    return [self getAttributeWithlineSpacing:lineSpacing alignment:NSTextAlignmentLeft font:font];
}

+(NSDictionary *)getAttributeWithlineSpacing:(CGFloat)lineSpacing alignment:(NSTextAlignment )alignment font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    //设置行间距
    paraStyle.lineSpacing = lineSpacing;
    //    paraStyle.hyphenationFactor = 1.0;
    //    paraStyle.firstLineHeadIndent = 0.0;
    //    paraStyle.paragraphSpacingBefore = 0.0;
    //    paraStyle.headIndent = 0;
    //    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    return dic;
}


//********************************************文本尺寸*****************************************************//
-(CGSize)getStringSizeWithFont:(UIFont *)font{
    
    CGSize size ;
    if(isIOS6){
        size = [self sizeWithFont:font];
    }else{
        size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    return size;
    
}

+(CGSize)getStringSizeWithFont:(UIFont *)font{
    return [[NSString string]getStringSizeWithFont:font];
}

-(CGSize)getStringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    
    CGSize resultSize ;
    if(isIOS6){
        resultSize = [self sizeWithFont:font constrainedToSize:size];
    }else{
        resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil ].size;
    }
    return resultSize;
    
}

-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size{
    CGSize resultSize ;
    
    resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil ].size;
    return resultSize;
}

-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute
{
    CGSize size = [self sizeWithAttributes:attribute];
    return size;
}

+(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size{
    return [[NSString new]getStringSizeWithAttribute:attribute constrainedToSize:size];
}

- (CGSize)calculatlabelWidthLabelWidth:(CGFloat)labelWidth labelHeight:(CGFloat)labelHeight font:(UIFont *)font isWidth:(BOOL)isWidth{
    CGSize size = CGSizeMake(0, 0);
    
    if (isWidth) {
        //求宽
        size = CGSizeMake(MAXFLOAT, labelHeight);
    }else{
        //求高
        size = CGSizeMake(labelWidth, MAXFLOAT);
    }
    CGSize labelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return labelSize;
}



@end
