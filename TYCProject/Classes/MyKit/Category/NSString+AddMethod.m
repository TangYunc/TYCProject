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

//价格：¥300.66
- (NSMutableAttributedString *)changeTextContent:(NSString *)textContent

          stringArray:(NSArray *)strArray

           colorArray:(NSArray *)colorArray

            fontArray:(NSArray *)fontArray {
    
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc] initWithString:textContent];
    
    NSString *str = nil;
    
    UIFont *font = nil;
    
    NSRange range = NSMakeRange(0, 0);
    
    for (NSInteger i = 0; i < strArray.count; i++) {
        
        //NSLog(@"---> strArray.count = %ld",strArray.count);
        
        str = strArray[i];
        
        NSUInteger location = [[mutAttStr string] rangeOfString:str].location;
        
        NSUInteger length   = [[mutAttStr string] rangeOfString:str].length;
        
        range = NSMakeRange(location, length);
        
        // 改变颜色
        
        if (colorArray.count >= (i+1)) {
            
            [mutAttStr addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:range];
            
        }
        
        // 改变字体大小
        
        if (fontArray.count >= (i+1)) {
            
            font = [UIFont systemFontOfSize:[fontArray[i] floatValue]];
            
            [mutAttStr addAttribute:NSFontAttributeName value:font range:range];
            
        }
        
    }
    return mutAttStr;
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
    CGSize labelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    //MARK:因为涉及到界面适配，所以难免出现小数，这时候采用四舍五入并且加1可以防止小数问题
    labelSize = CGSizeMake(labelSize.width + 1, labelSize.height + 1);
    return labelSize;
}

- (NSArray<NSValue *> *)getRangeStrArrWithInitialText:(NSString*)initialText regexString:(NSString*)regexString{
    /*
     备注：1、array中存的是N个字典，每个字典中存了两个值：子串、子串位置，结构如下图
     2、字典中的range是NSValue，需要转换成NSRange使用
     (
     {
     subString = "我是TYC要改变的字符串";
     subStringRange = "NSRange: {6, 20}";
     }
     ）
     */
    NSMutableArray *tempMArr = [NSMutableArray array];
    [self searchAllTextRangeWithInitialArray:tempMArr initialText:initialText regexString:regexString];
    NSMutableArray *resultMArr = [NSMutableArray array];
    for (NSDictionary *tempDic in tempMArr) {
        NSValue *rangeValue = tempDic[@"subStringRange"];
        [resultMArr addObject:rangeValue];
    }
    return resultMArr;
}

- (void)searchAllTextRangeWithInitialArray:(NSMutableArray*)initialArray initialText:(NSString*)initialText regexString:(NSString*)regexString{
    //思路：通过循环，搜索到第一个之后，先把第一个的信息打包成字典存进数组，再次搜索，把上次的信息字典取出来，根据上一个位置信息，把主串截取为在那之后的串，记录新串的头字符在主串中的位置，在新串中再次搜索，搜索到的range的location需要加上新串的头字符在主串中的位置，打包信息存进数组，再次搜索，直到搜索不到信息。
    if (initialArray.count == 0) {//如果此时传入的array是空
        NSRange range = [initialText rangeOfString:regexString options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            //包装字典，存进数组
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"subString"] = [initialText substringWithRange:range];
            dict[@"subStringRange"] = [NSValue valueWithRange:range];
            [initialArray addObject:dict];
            //递归调用
            [self searchAllTextRangeWithInitialArray:initialArray initialText:initialText regexString:regexString];
        }else{
            return;
        }
    }else{//如果数组中已经有值了
        //1、取数组中最后一个字典，记录后串在原串中的起始位置，把该串及其之前的串去掉生成新串
        NSMutableDictionary *lastDict = [initialArray lastObject];
        NSRange lastRange = [lastDict[@"subStringRange"] rangeValue];
        NSUInteger newStringBeginLocation = lastRange.location +  lastRange.length;
        NSString *newString = [initialText substringFromIndex:newStringBeginLocation];
        //2、在新串中找符合的子串，如果找到，包装存进数组
        NSRange rangeInNewString = [newString rangeOfString:regexString options:NSRegularExpressionSearch];
        if(rangeInNewString.location != NSNotFound) {
            //包装字典，存进数组
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"subString"] = [newString substringWithRange:rangeInNewString];
            NSRange rangeIninitialText = NSMakeRange(rangeInNewString.location + newStringBeginLocation, rangeInNewString.length);
            dict[@"subStringRange"] = [NSValue valueWithRange:rangeIninitialText];
            [initialArray addObject:dict];
            //递归调用
            [self searchAllTextRangeWithInitialArray:initialArray initialText:initialText regexString:regexString];
        }else{
            return;
        }
    }
}

@end
