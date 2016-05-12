//
//  LEEMenuSteps.m
//  Internet Speed Meter
//
//  Created by lee on 16/4/7.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEMenuSteps.h"

@implementation LEEMenuSteps
+(instancetype)getDataWithDict:(NSDictionary*)dict{
    LEEMenuSteps *menuS=[self new];
    [menuS setValuesForKeysWithDictionary:dict];
    return menuS;
}
@end
