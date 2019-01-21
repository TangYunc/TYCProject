//
//  NSArray+AddMethod.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/21.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "NSArray+AddMethod.h"

@implementation NSArray (AddMethod)

//********************************************文本判空*****************************************************//
+ (BOOL)isBlankArray:(NSArray *)array{
    
    if (array == nil) {
        return YES;
    }
    
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (array.count == 0) {
        return YES;
    }
    
    return NO;
}

@end
