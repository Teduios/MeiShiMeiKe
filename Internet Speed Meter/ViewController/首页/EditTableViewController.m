//
//  EditTableViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/17.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "EditTableViewController.h"
#import "ReviseViewController.h"
#import "User.h"

#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height
@interface EditTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic)  UIDatePicker *datePicker;
@property (nonatomic,strong) UITableViewCell *cell;
@property (nonatomic,strong) UIView *MyView;
@property (nonatomic,strong) NSUserDefaults *useDefaults;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UITextView *personalityTextView;

@end

@implementation EditTableViewController
-(NSUserDefaults *)useDefaults{
    if (!_useDefaults) {
        _useDefaults=[NSUserDefaults standardUserDefaults];
    }
    return _useDefaults;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.day.text=[self.useDefaults objectForKey:@"生日"];
    self.gender.text=[self.useDefaults objectForKey:@"性别"];
    self.nickName.text=[self.useDefaults objectForKey:@"昵称"];
    self.address.text=[self.useDefaults objectForKey:@"地址"];
    self.personalityTextView.text=[self.useDefaults objectForKey:@"个性签名"];
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"saveForImage"];
    self.headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filepath] scale:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    self.cell=cell;
    switch (cell.tag) {
        case 1:
        case 5:
            //跳转修改界面
            [self performSegueWithIdentifier:@"editUserInfo" sender:indexPath];
            break;
        case 2:
            //选中头像图片
            [self createActionSheet];
            break;
        case 3:
            [self chooseDate];
            break;
        case 4:
            [self chooseGender];
            break;
    }
}
-(void)createActionSheet{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请选择" message:@"获取头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *camera=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相机的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypeCamera)];
    }];
    UIAlertAction *photoLibrary=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相册的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypePhotoLibrary)];
    }];
    
    
    [alert addAction:cancel];
    [alert addAction:camera];
    [alert addAction:photoLibrary];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)chooseHeadImage:(UIImagePickerControllerSourceType) type{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    //允许编辑图片
    imagePicker.allowsEditing=YES;
    imagePicker.sourceType=type;
    //设置代理
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//imagePickerController 代理方法，当我们选择完图片是调用，会把选择的图片，通过参数交给我
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //把选中图片取出来
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.headImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    //self.block_back(self.headImageView.image);
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"saveForImage"];
    [imageData writeToFile:filepath atomically:YES];
}

-(void)chooseDate{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 30)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    self.MyView=view;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50, 5, 40, 20)];
    
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    self.datePicker=[[UIDatePicker alloc]init];
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    self.datePicker.frame=CGRectMake(0, SCREEN_HEIGHT+30, SCREEN_WIDTH, 150);
    self.datePicker.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.datePicker];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.datePicker.frame=CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 150);
            view.frame=CGRectMake(0, SCREEN_HEIGHT-230, SCREEN_WIDTH, 30);
        } completion:nil];
    NSString *filepath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) [0];
    NSLog(@"%@",filepath);
    //self.cell.detailTextLabel.text=[self.useDefults objectForKey:@"生日"];
}
-(void)choose:(UIView*)view{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.datePicker.frame=CGRectMake(0, SCREEN_HEIGHT+30, SCREEN_WIDTH, 150);
        self.MyView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 30);
    } completion:nil];
    NSDate *selectedDate = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd ";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    self.cell.detailTextLabel.text=dateString;
    [self.useDefaults setObject:dateString forKey:@"生日"];
}

-(void)chooseGender{
    UIAlertController *alertSheet=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *man=[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.cell.detailTextLabel.text=action.title;
        [self.useDefaults setObject:self.cell.detailTextLabel.text forKey:@"性别"];
    }];
    UIAlertAction *women=[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.cell.detailTextLabel.text=action.title;
        [self.useDefaults setObject:self.cell.detailTextLabel.text forKey:@"性别"];
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertSheet addAction:man];
    [alertSheet addAction:women];
    [alertSheet addAction:cancel];
    
    [self presentViewController:alertSheet animated:YES completion:nil];
    
    NSLog(@"%@",self.cell.detailTextLabel.text);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ReviseViewController *reviseVC=segue.destinationViewController;
    
    reviseVC.block_str=^(NSString *str){
        self.cell.detailTextLabel.text=str;
        if (self.cell.tag==1) {
            [self.useDefaults setObject:str forKey:@"昵称"];
        }else{
            [self.useDefaults setObject:str forKey:@"地址"];
        }
    };
    reviseVC.str=self.cell.detailTextLabel.text;
    
}

- (IBAction)back:(id)sender {
    self.block_back(self.headImageView.image,self.nickName.text,self.personalityTextView.text);
    [self.navigationController popViewControllerAnimated:YES];
    [self.useDefaults setObject:self.personalityTextView.text forKey:@"个性签名"];
}


@end
