//
//  LEEAreaMenuCell.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/29.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEAreaMenuCell.h"

@interface LEEAreaMenuCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LEEAreaMenuCell
+(LEEAreaMenuCell *)cellForTableView:(UITableView *)tableView
{
    LEEAreaMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[LEEAreaMenuCell alloc]init];
    }
    return cell;
}
-(void)setData:(LEEAreaMenu*)areaMenu{
    self.headerImageView.layer.cornerRadius=5;
    self.headerImageView.clipsToBounds=YES;
    self.headerImageView.image=[UIImage imageNamed:areaMenu.imageName];
    self.titleLabel.text=areaMenu.name;
}

@end
