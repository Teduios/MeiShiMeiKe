//
//  LHDNavigationViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/17.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LHDNavigationViewController.h"

@interface LHDNavigationViewController ()

@end

@implementation LHDNavigationViewController
+(void)initialize{
    if (self==[LHDNavigationViewController class]) {
       
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //把tabBarItem中选中时的图片取出  然后设置图片的模式 为 原色
    //UIImage *selectedImage=[self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //将新的图片设置为 tabBarItem的选中图片
    //self.tabBarItem.selectedImage=selectedImage;
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
