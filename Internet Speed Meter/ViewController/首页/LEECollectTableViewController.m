//
//  LEECollectTableViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/4/7.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEECollectTableViewController.h"
#import "LEECollectTableViewCell.h"
#import "LEENetworkManager.h"
#import "LEEDataManager.h"
#import "LEEDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+Refresh.h"


@interface LEECollectTableViewController ()
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) LEEMenu *menu;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSMutableArray *Mstring;

@end

@implementation LEECollectTableViewController
-(NSMutableArray *)array{
    if (!_array) {
        _array=[NSMutableArray array];
    }
    return _array;
}
-(NSMutableArray *)Mstring{
    if (!_Mstring) {
        _Mstring = [[NSMutableArray alloc]init];
    }
    return _Mstring;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_"]];

    NSString *strPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:strPath error:nil];
    for (NSString *fileName in fileNames) {
        if ([fileName hasSuffix:@"png"]||[fileName hasSuffix:@"jpg"]) {
            NSLog(@"%@",fileName);
            self.fileName=fileName;
            //[self.Mstring addObject:fileName];
            [self.array addObject:[strPath stringByAppendingPathComponent:fileName]];
        }
    }
    
    //[self.tableView beginHeaderRefresh];
    NSLog(@"%@",NSHomeDirectory());
    NSLog(@"%ld",self.array.count);
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //添加下拉刷新
    __weak typeof(self) weakSelf =self;
    [self.tableView addHeaderRefresh:^{
        NSString *strPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:strPath error:nil];
        [weakSelf.array removeAllObjects];
        for (NSString *fileName in fileNames) {
            if ([fileName hasSuffix:@"png"]||[fileName hasSuffix:@"jpg"]) {
                NSLog(@"%@",fileName);
                weakSelf.fileName=fileName;
                //if ([weakSelf.array indexOfObject:fileName]==NSNotFound) {
                
                    [weakSelf.array addObject:[strPath stringByAppendingPathComponent:fileName]];
               // }
                
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView endHeaderRefresh];
        //[self sendResquestToServer];
    }];
    [self.tableView beginHeaderRefresh];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LEECollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //cell.HeaderImageView.image=[UIImage imageNamed:self.array[indexPath.row]];
    //NSString *string=self.Mstring[indexPath.row];
    //cell.title.text=[self.Mstring[indexPath.row] substringWithRange:NSMakeRange(0, string.length-4)] ;
    LEEMenu *menu = [NSKeyedUnarchiver unarchiveObjectWithFile:self.array[indexPath.row]];
    NSURL *url =[NSURL URLWithString:menu.albums];
    [cell.HeaderImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
    cell.HeaderImageView.layer.cornerRadius=5;
    cell.HeaderImageView.clipsToBounds=YES;
    cell.title.text=menu.title;
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LEEDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    LEEMenu *menu = [NSKeyedUnarchiver unarchiveObjectWithFile:self.array[indexPath.row]];
    NSLog(@"%@",menu);
    self.menu=menu;
    NSArray *array=[LEEDataManager getALlMEnuSteps:menu];
    detailVC.steps= array;
    detailVC.str=menu.title;
    detailVC.menu=menu;
    NSLog(@"%@",self.menu.albums);
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -- 当前行是否可以编辑  
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //LEEMenu *menu = [NSKeyedUnarchiver unarchiveObjectWithFile:self.array[self.array.count- indexPath.row-1]];
        NSString *str = self.array[indexPath.row];
        NSLog(@"%@",str);
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:menu.albums];
        [manager removeItemAtPath:str error:nil];
        
        [self.array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        NSLog(@"%ld",indexPath.row);
        
        
        //[tableView reloadData];
    }
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
