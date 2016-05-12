//
//  ReviseViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/17.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "ReviseViewController.h"

@interface ReviseViewController ()
@property (weak, nonatomic) IBOutlet UITextField *reviseTextField;

@end

@implementation ReviseViewController
- (IBAction)finishEdit:(UIBarButtonItem *)sender {
    self.block_str(self.reviseTextField.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reviseTextField.text=self.str;
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
