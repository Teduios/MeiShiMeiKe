//
//  LEEMenuTableViewCell.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/24.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEMenuTableViewCell.h"


@interface LEEMenuTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LEEMenuTableViewCell

-(void)setData:(LEEMenu*)menu{
    
    //self.headerImageView.image=[UIImage imageNamed:menu.imageName];
   // self.titleLabel.text=menu.title;
}

@end
