//
//  LEERootViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/23.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEERootViewController.h"
#import "TRTabBarViewController.h"

@implementation LEERootViewController
-(void)awakeFromNib{
    self.contentViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    self.leftMenuViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
    self.backgroundImage=[UIImage imageNamed:bacakground];//[UIImage imageNamed:@"bg_night_snow"];
    self.panGestureEnabled=YES;
    self.panFromEdge=YES;
    self.contentViewShadowColor=[UIColor blackColor];
    self.contentViewShadowEnabled=YES;
    self.menuPreferredStatusBarStyle=UIStatusBarStyleLightContent;
}
@end
