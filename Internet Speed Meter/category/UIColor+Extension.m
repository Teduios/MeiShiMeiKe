//
//  UIColor+Extension.m
//  Demo2_
//
//  Created by lee on 16/2/25.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+(UIColor*)colorWith255Red:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue Alpha:(NSInteger)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}
@end
