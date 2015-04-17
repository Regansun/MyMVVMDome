//
//  LoginViewModel.m
//  MyMVVMDome
//
//  Created by Regan on 15/4/15.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import "LoginViewModel.h"
#import "PublicTableViewController.h"

@implementation LoginViewModel

- (void)loginActionWithUserName:(NSString *)userName passWord:(NSString *)passWord complete:(SignInSuccessBlock)success{
    //如果实现网路实现登陆  就调用一下方法
    /*[NetRequestClass NetRequestPOSTWithRequestURL:@"" WithParameter:nil WithReturnValeuBlock:^(id returnValue) {
        //处理正确的数据 通过returnBlock回调
        self.returnBlock(returnValue);
    } WithErrorCodeBlock:^(id errorCode) {
        //处理错误的数据 通过errorBlock回调
        self.errorBlock(errorCode);
    } WithFailureBlock:^{
        //处理网络异常 通过failureBlock回调
        self.failureBlock(@"网络异常！");
    }];*/
    if ([userName isEqualToString:@"admin"] && [passWord isEqualToString:@"admin"]) {
        success(YES);
    }else{
        success(NO);
    }
}

- (void)forgetPasswordWithUsername:(NSString *)userName complete:(ForgetPasswordBlock)success{
    if ([userName isEqualToString:@"admin"]) {
        success(YES,@"admin");
    }else{
        success(NO,@"没用这个用户");
    }
}

- (void)successLoginWithUserModel:(id)userModel withViewController:(UIViewController *)superController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PublicTableViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"PublicTableViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    //detailController.publicModel = publicModel;
    [superController presentViewController:nav animated:YES completion:nil];
}

@end
