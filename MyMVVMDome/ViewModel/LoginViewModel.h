//
//  LoginViewModel.h
//  MyMVVMDome
//
//  Created by Regan on 15/4/15.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import "ViewModelClass.h"

@interface LoginViewModel : ViewModelClass

- (void)loginActionWithUserName:(NSString *)userName passWord:(NSString *)passWord;

- (void)successLoginWithUserModel:(id)userModel withViewController:(UIViewController *)superController;

@end
