//
//  LEEBackgroundViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/4/25.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEEBackgroundViewController.h"
#import "LEEBackground.h"
@interface LEEBackgroundViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *AllBackground;
@end

@implementation LEEBackgroundViewController
-(NSArray *)AllBackground{
    if (!_AllBackground) {
        _AllBackground = [LEEBackground allBackground];
    }
    return _AllBackground;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.AllBackground.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectImage" forIndexPath:indexPath];
    LEEBackground *bg = self.AllBackground[indexPath.row];
    cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:bg.backgroundName]];
    
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LEEBackground *bg = self.AllBackground[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    collectionView.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:bg.backgroundName]];
    self.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:bg.backgroundName]];
    self.block_bg(bg.backgroundName);
    [[NSUserDefaults standardUserDefaults]setObject:bg.backgroundName forKey:@"背景"];
    
}
@end
