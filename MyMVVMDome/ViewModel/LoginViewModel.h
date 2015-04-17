//
//  LoginViewModel.h
//  MyMVVMDome
//
//  Created by Regan on 15/4/15.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import "ViewModelClass.h"

typedef void(^SignInSuccessBlock) (BOOL success);
typedef void(^ForgetPasswordBlock) (BOOL success, NSString *pwd);

@interface LoginViewModel : ViewModelClass

- (void)loginActionWithUserName:(NSString *)userName passWord:(NSString *)passWord complete:(SignInSuccessBlock)success;

- (void)forgetPasswordWithUsername:(NSString *)userName complete:(ForgetPasswordBlock)success;

- (void)successLoginWithUserModel:(id)userModel withViewController:(UIViewController *)superController;

@end
