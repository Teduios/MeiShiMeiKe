//
//  MeTableViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/17.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "MeTableViewController.h"
#import "EditTableViewController.h"

#import "LEEBackgroundViewController.h"

@interface MeTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personalityLabel;
@property (weak, nonatomic) IBOutlet UILabel *CachesLabel;

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCaches];
    self.headImageView.layer.cornerRadius=30;
    self.headImageView.clipsToBounds = YES;
    
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"saveForImage"];
    self.headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filepath] scale:1];
    if (self.headImageView.image==nil) {
        self.headImageView.image=[UIImage imageNamed:@"002"];
    }
    
    self.nickNameLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"昵称"];
    if (self.nickNameLabel.text==nil) {
        self.nickNameLabel.text=@"lee";
    }
    
    self.personalityLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"个性签名"];
    if (self.personalityLabel.text==nil) {
        self.personalityLabel.text=@"请输入个性签名";
    }
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[[NSUserDefaults standardUserDefaults] objectForKey:@"背景" ]]];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self showCaches];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc=segue.destinationViewController;
    if ([vc isKindOfClass:[EditTableViewController class]]) {
        EditTableViewController *editVC=(EditTableViewController*)vc;
        editVC.block_back=^(UIImage *image,NSString *str,NSString *text){
            self.headImageView.image=image;
            self.nickNameLabel.text=str;
            self.personalityLabel.text=text;
            };
        
    }
    if ([vc isKindOfClass:[LEEBackgroundViewController class]]) {
        LEEBackgroundViewController *leeBg =(LEEBackgroundViewController*)vc;
        
        leeBg.block_bg=^(NSString *str){
            self.tableView.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:str]];
        };
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag==10001) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"确认清理?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *NoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:filePath error:nil];
            [self showCaches];
        }];
        [alert addAction:NoAction];
        [alert addAction:yesAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
-(void)showCaches{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSLog(@"%.1f",[[dict objectForKey:NSFileSize] floatValue]/1024.0);
    self.CachesLabel.text=[NSString stringWithFormat:@"%.1fMB", ([[dict objectForKey:NSFileSize] floatValue]/1024.0)];
    self.CachesLabel.textColor=[UIColor orangeColor];
}
@end
