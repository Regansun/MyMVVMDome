//
//  PublicTableViewController.m
//  MyMVVMDome
//
//  Created by Regan on 15/4/8.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import "PublicTableViewController.h"
#import "PublicCell.h"
#import "PublicWeiboViewModel.h"

@interface PublicTableViewController ()

@property (strong, nonatomic) NSArray *publicModelArray;

@end

@implementation PublicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PublicWeiboViewModel *publicViewModel = [[PublicWeiboViewModel alloc] init];
    [publicViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        [SVProgressHUD dismiss];
        _publicModelArray = returnValue;
        [self.tableView reloadData];
        DDLog(@"%@",_publicModelArray);
        
    } WithErrorBlock:^(id errorCode) {
        
        [SVProgressHUD dismiss];
        
    } WithFailureBlock:^{
        
        [SVProgressHUD dismiss];
        
    }];
    
    [publicViewModel fetchPublicWeiBo];
    
    [SVProgressHUD showWithStatus:@"正在获取用户信息……" maskType:SVProgressHUDMaskTypeBlack];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _publicModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PublicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicCell" forIndexPath:indexPath];
    [cell setValueWithDic:_publicModelArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicWeiboViewModel *publicViewModel = [[PublicWeiboViewModel alloc] init];
    [publicViewModel weiboDetailWithPublicModel:_publicModelArray[indexPath.row] WithViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
