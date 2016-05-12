//
//  LEECategoryTableViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/4/6.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEECategoryTableViewController.h"
#import "LEECategoryTableViewCell.h"
#import "LEENetworkManager.h"
#import "LEEDataManager.h"
#import "LEEMenu.h"
#import "UIImageView+WebCache.h"
#import "LEEDetailViewController.h"
#import "UIScrollView+Refresh.h"

@interface LEECategoryTableViewController ()
@property (nonatomic,strong) NSArray *CategoryMenus;
@property (nonatomic) NSInteger pg;
@property (nonatomic,assign) NSInteger rn;
//@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@end

@implementation LEECategoryTableViewController
-(NSMutableArray *)mutableArray{
    if (!_mutableArray) {
        _mutableArray=[NSMutableArray array];
    }
    return _mutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendResquestToServer];
    self.pg = arc4random()%10;
    
    self.tableView.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:bacakground]];
    
}


- (IBAction)back:(id)sender {
    self.pg++;
    [self sendResquestToServer];
    
}
-(void)sendResquestToServer{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urlStr=@"http://apis.haoservice.com/lifeservice/cook/query";
        NSDictionary *param=@{
                              @"menu":(self.titleName.length==0?@"蛋糕":self.titleName),
                              @"pn":[NSString stringWithFormat:@"%ld",self.pg],
                              @"rn":@"30",
                              @"key":@"54111801684e4b76bc86878692ef427f"
                              };
        [LEENetworkManager sendGetRequestWithUrl:urlStr parameters:param success:^(id responseObject) {
            NSLog(@"aa");
            
            self.CategoryMenus=[LEEDataManager getAllMenuData:responseObject];
            
            NSLog(@"%ld",self.CategoryMenus.count);
            [self.tableView reloadData];
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        } failure:^(NSError *error) {
            NSLog(@"22");
        }];
    });
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.CategoryMenus.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LEECategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    LEEMenu *menu=self.CategoryMenus[indexPath.row];
    NSURL *url=[NSURL URLWithString:menu.albums];
    [cell.HeaderImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
    cell.HeaderImageView.layer.cornerRadius=5;
    cell.HeaderImageView.clipsToBounds=YES;
    cell.titleLabel.text=menu.title;
    cell.detailLabels.text=menu.ingredients;
    NSLog(@"%@",cell.detailLabels.text);
    NSLog(@"%@",NSHomeDirectory());
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LEEDetailViewController *detailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    LEEMenu *menu=self.CategoryMenus[indexPath.row];
    NSArray *array = [LEEDataManager getALlMEnuSteps:menu];
    detailVC.steps=array;
    NSLog(@"%@",array);
    detailVC.str=menu.title;
    detailVC.menu =menu;
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
