//
//  LEEAllTypeMenu.m
//  Internet Speed Meter
//
//  Created by lee on 16/4/23.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEAllTypeMenu.h"

@implementation LEEAllTypeMenu
+(NSArray *)AllTypeMenu{
    LEEAllTypeMenu *t1 =[self new];
    t1.type = @"家常菜";
    
    LEEAllTypeMenu *t2 =[self new];
    t2.type = @"快手菜";
    
    LEEAllTypeMenu *t3 =[self new];
    t3.type = @"创意菜";
    
    //LEEAllTypeMenu *t4 =[self new];
    //t4.type = @"素材";
    
    LEEAllTypeMenu *t5 =[self new];
    t5.type = @"凉菜";
    
    LEEAllTypeMenu *t6 =[self new];
    t6.type = @"面食";
    
    LEEAllTypeMenu *t7 =[self new];
    t7.type = @"汤";
    return @[t1,t2,t3,t5,t6,t7];
}
@end


