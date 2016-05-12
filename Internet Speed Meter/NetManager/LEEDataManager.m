//
//  LEEDataManager.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/28.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEDataManager.h"
#import "LEEMenu.h"
#import "LEEMenuSteps.h"

@implementation LEEDataManager
+(NSArray *)getAllMenuData:(id)responseObject{
    NSArray *menuArray=responseObject[@"result"];
    NSMutableArray *mutableArray=[NSMutableArray array];
    for (NSDictionary *dict in menuArray) {
        LEEMenu *menu=[LEEMenu getDataWithDict:dict];
        [mutableArray addObject:menu];
    }
    return [mutableArray copy];
}
+(NSArray*)getALlMEnuSteps:(LEEMenu*)menu{
    NSMutableArray *array=[NSMutableArray array];
    for (NSDictionary *dict in menu.steps) {
        LEEMenuSteps *menuS=[LEEMenuSteps getDataWithDict:dict];
        [array addObject:menuS];
    }
    return array;
}
@end
