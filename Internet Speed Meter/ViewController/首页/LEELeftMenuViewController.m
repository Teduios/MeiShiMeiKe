//
//  LEELeftMenuViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/23.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEELeftMenuViewController.h"
#import "LEEAreaMenu.h"
#import "LEEAreaMenuCell.h"
#import "RESideMenu.h"
//#import "LEERootViewController.h"


@interface LEELeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *allAreaMenus;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LEELeftMenuViewController
-(NSArray *)allAreaMenus{
    if (!_allAreaMenus) {
        _allAreaMenus=[LEEAreaMenu AreaMenu];
    }
    return _allAreaMenus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.layer.cornerRadius=5;
    self.imageView.clipsToBounds=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - 三问
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allAreaMenus.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.backgroundColor=[UIColor clearColor];
    LEEAreaMenuCell *cell=[LEEAreaMenuCell cellForTableView:tableView];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    if (indexPath.row==0) {
        cell.textLabel.text=@"选你所爱";
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.userInteractionEnabled=NO;
    }else{
        
         LEEAreaMenu *areaMenu=self.allAreaMenus[indexPath.row-1];
        [cell setData:areaMenu];
    }
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LEEAreaMenu *areaMenu=self.allAreaMenus[indexPath.row-1];
    //LEERootViewController *rootVC=[LEERootViewController new];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DidMenuChange" object:self userInfo:@{@"MenuName":areaMenu.name}];
    //[self.navigationController popToViewController:rootVC animated:YES];
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.sideMenuViewController hideMenuViewController];
}

@end
