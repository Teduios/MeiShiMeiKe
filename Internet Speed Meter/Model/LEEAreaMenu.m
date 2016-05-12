//
//  LEEAreaMenu.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/29.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEAreaMenu.h"

@implementation LEEAreaMenu
+(NSArray *)AreaMenu{
    LEEAreaMenu *am1=[[LEEAreaMenu alloc]init];
    am1.name=@"特色菜";
    am1.imageName=@"bakery";
    
    LEEAreaMenu *am2=[[LEEAreaMenu alloc]init];
    am2.name=@"蛋糕";
    am2.imageName=@"cake";
    
    LEEAreaMenu *am3=[[LEEAreaMenu alloc]init];
    am3.name=@"面包";
    am3.imageName=@"Bread";
    
    LEEAreaMenu *am4=[[LEEAreaMenu alloc]init];
    am4.name=@"面条";
    am4.imageName=@"noodles2";
    
    LEEAreaMenu *am5=[[LEEAreaMenu alloc]init];
    am5.name=@"汤";
    am5.imageName=@"Soup2";
    
    LEEAreaMenu *am6=[[LEEAreaMenu alloc]init];
    am6.name=@"粥";
    am6.imageName=@"punch";
    
    LEEAreaMenu *am7=[[LEEAreaMenu alloc]init];
    am7.name=@"甜点";
    am7.imageName=@"cupcake";
    
    LEEAreaMenu *am8=[[LEEAreaMenu alloc]init];
    am8.name=@"饮品";
    am8.imageName=@"chocolate";
    
    return @[am1,am2,am3,am7,am5,am6,am4,am8];
}
@end
