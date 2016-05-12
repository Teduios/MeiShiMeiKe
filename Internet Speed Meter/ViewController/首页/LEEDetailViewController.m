//
//  LEEDetailViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/24.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEDetailViewController.h"
#import "LEEDetailTableViewCell.h"
#import "LEEMenuSteps.h"
#import "UIImageView+WebCache.h"


@interface LEEDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *collect;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic,assign) NSInteger x;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@end

@implementation LEEDetailViewController
-(NSArray *)steps{
    if (!_steps) {
        _steps=[NSArray array];
    }
    return _steps;
}
-(NSMutableArray *)mutableArray{
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight=70;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.isSelected=NO;
    self.navigationItem.title=self.str;
    self.imageView.image=[UIImage imageNamed:bacakground];
    //self.collect.image = [[UIImage imageNamed:@"star_empty1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:self.menu.albums] ==YES) {
//        self.collect.image=[[UIImage imageNamed:@"star_full1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        self.collect.enabled=NO;
//    }else
        self.collect.image = [[UIImage imageNamed:@"star_empty1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
- (IBAction)click:(UIBarButtonItem *)sender {
    //self.x =1000;
    if (!self.isSelected) {
        sender.image=[[UIImage imageNamed:@"star_full1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.isSelected=YES;
        //self.x = [[[NSUserDefaults standardUserDefaults] objectForKey:@"数字"] integerValue];
        NSString *filePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[self.menu.albums lastPathComponent]];
        //[self.mutableArray addObject:self.menu];
        
        [NSKeyedArchiver archiveRootObject:self.menu toFile:filePath];
        //self.x++;
        //[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",self.x] forKey:@"数字"];
        NSLog(@"%@",NSHomeDirectory());
        
    }else{
        sender.image=[[UIImage imageNamed:@"star_empty1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.isSelected=NO;
        //[[NSUserDefaults standardUserDefaults] setBool:self.isSelected forKey:@"判断"];
    }
  //  self.block(self.isSelected);
}

#pragma mark -- UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.steps.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LEEDetailTableViewCell *cell ;
    if (indexPath.section==0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell2" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:self.menu.albums];
        [cell.headerImageView2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
        cell.label1.text =[NSString stringWithFormat:@"材料:   %@",self.menu.ingredients];
        cell.label1.textColor = [UIColor yellowColor];
        cell.label2.text =[NSString stringWithFormat:@"调料:   %@",self.menu.burden];
        cell.label2.textColor = [UIColor yellowColor];
        cell.label3.text =[NSString stringWithFormat:@"简介:   %@",self.menu.intro];
        
        return cell;
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
        LEEMenuSteps *menuS=self.steps[indexPath.section-1];
        NSURL *url=[NSURL URLWithString:menuS.img];
        //NSData *data=[NSData dataWithContentsOfURL:url];
        [cell.headerImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
        
        cell.label.text=menuS.step;
        cell.selectionStyle=UITableViewCellEditingStyleNone;
        return cell;
    }
    
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    tableView.estimatedRowHeight=70;
//    return UITableViewAutomaticDimension;
//}



@end
