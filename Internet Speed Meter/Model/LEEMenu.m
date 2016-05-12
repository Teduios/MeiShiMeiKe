//
//  LEEMenu.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/24.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEMenu.h"

@implementation LEEMenu
+(instancetype)getDataWithDict:(NSDictionary *)dict{
    LEEMenu *menu=[[self alloc]init];
    menu.title=dict[@"title"];
    menu.tags=dict[@"tags"];
    menu.intro=dict[@"intro"];
    menu.ingredients=dict[@"ingredients"];
    menu.burden=dict[@"burden"];
    menu.albums=dict[@"albums"];
    menu.steps=dict[@"steps"];
    return menu;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_albums forKey:@"albums"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_ingredients forKey:@"ingredients"];
    [aCoder encodeObject:_burden forKey:@"burden"];
    [aCoder encodeObject:_steps forKey:@"steps"];
    [aCoder encodeObject:_intro forKey:@"intro"];
    [aCoder encodeObject:_albums forKey:@"albums"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [self init]) {
        _albums = [aDecoder decodeObjectForKey:@"albums"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _steps = [aDecoder decodeObjectForKey: @"steps"];
        _intro = [aDecoder decodeObjectForKey:@"intro"];
        _burden = [aDecoder decodeObjectForKey:@"burden"];
        _ingredients = [aDecoder decodeObjectForKey:@"ingredients"];
        _albums = [aDecoder decodeObjectForKey:@"albums"];
    }
    return self;
}
@end
