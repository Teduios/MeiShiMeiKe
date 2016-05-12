//
//  LEEBackground.m
//  Internet Speed Meter
//
//  Created by lee on 16/4/25.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEBackground.h"

@implementation LEEBackground
+(NSArray *)allBackground{
    LEEBackground *bg1 = [self new];
    bg1.backgroundName = @"bg_";
    
    LEEBackground *bg2 = [self new];
    bg2.backgroundName = @"bg_fog";
    
    LEEBackground *bg3 = [self new];
    bg3.backgroundName = @"bg_haze";
    
    LEEBackground *bg4 = [self new];
    bg4.backgroundName = @"bg_na";
    
    LEEBackground *bg5 = [self new];
    bg5.backgroundName = @"bg_middle_rain";
    
    LEEBackground *bg6 = [self new];
    bg6.backgroundName = @"bg_night_fog";
    
    LEEBackground *bg7 = [self new];
    bg7.backgroundName = @"bg_night_rain";
    
    LEEBackground *bg8 = [self new];
    bg8.backgroundName = @"bg_night_snow";
    
    LEEBackground *bg9 = [self new];
    bg9.backgroundName = @"bg_night_sunny";
    
    LEEBackground *bg10 = [self new];
    bg10.backgroundName = @"bg_red";
    
    LEEBackground *bg11 = [self new];
    bg11.backgroundName = @"bg_yellow";
    
    LEEBackground *bg12 = [self new];
    bg12.backgroundName = @"bg_sunny";
    
    return @[bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9,bg10,bg11,bg12];
}
@end
