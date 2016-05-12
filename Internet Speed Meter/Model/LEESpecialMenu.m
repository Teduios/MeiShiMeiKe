//
//  LEESpecialMenu.m
//  Internet Speed Meter
//
//  Created by lee on 16/4/5.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEESpecialMenu.h"

@implementation LEESpecialMenu
+(NSArray *)SpecialMenu{
    LEESpecialMenu *menu=[self new];
    menu.title=@"春季特色";
    menu.imageName=@"chunji2.jpg";
    
    LEESpecialMenu *menu2=[self new];
    menu2.title=@"夏季饮食";
    menu2.imageName=@"xiaji2.jpg";
    
    LEESpecialMenu *menu3=[self new];
    menu3.title=@"秋季菜谱";
    menu3.imageName=@"qiuji.jpg";
    
//    LEESpecialMenu *menu4=[self new];
//    menu4.title=@"零食";
//    menu4.imageName=@"lingshi.jpg";
    
    LEESpecialMenu *menu5 =[self new];
    menu5.title = @"冬季风味";
    menu5.imageName=@"dongji.jpg";
    return @[menu,menu2,menu3,menu5];
}
@end
