//
//  TRTabBarViewController.m
//  Demo2_
//
//  Created by lee on 16/2/25.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "TRTabBarViewController.h"
#import "UIColor+Extension.h"
@interface TRTabBarViewController ()

@end

@implementation TRTabBarViewController

+(void)initialize
{
    if (self==[TRTabBarViewController class]) {
        UITabBar *tabBar=[UITabBar appearance];
        //设置背景
        //如果没有设置背景图  系统会自动场景一张灰色的背景图使用
        [tabBar setBackgroundImage:[UIImage imageNamed:@"toolbarBkg_white"]];
        //[tabBar setBackgroundColor:[UIColor yellowColor]];
        //如果直接设置背景颜色  被背景图片挡住  想要使用背景颜色  那么就先设置一张没有任何内容的背景图  那么就不会被挡住了
        
        //设置bar上呗选上的项的背景图
        //[tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected_back"]];
        //设置默认时字体
        UITabBarItem *tabBarItem=[UITabBarItem appearance];
        NSMutableDictionary *attributes=[NSMutableDictionary dictionary];
        attributes[NSFontAttributeName]=[UIFont systemFontOfSize:11];
        
        NSMutableDictionary *attributes2=[NSMutableDictionary dictionary];
        attributes2[NSFontAttributeName]=[UIFont systemFontOfSize:11];
        //attributes2[NSForegroundColorAttributeName]=[UIColor colorWithRed:26/255.0 green:178/255.0 blue:10/255.0 alpha:1];
        attributes2[NSForegroundColorAttributeName]=[UIColor colorWithRed:35/255.0 green:107/255.0 blue:160/255.0 alpha:1];
        
        //设置默认时的字体
        [tabBarItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
        //设置选中时的字体
        [tabBarItem setTitleTextAttributes:attributes2 forState:UIControlStateSelected];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
