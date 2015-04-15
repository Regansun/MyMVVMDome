//
//  LoginViewController.m
//  MyMVVMDome
//
//  Created by Regan on 15/4/14.
//  Copyright (c) 2015年 Regan. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdButton;

@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    LoginViewModel *viewModel = [LoginViewModel new];
    
    /**
     <#Description#>
     
     :returns: <#return value description#>
     */
    self.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [viewModel loginActionWithUserName:self.userName.text passWord:self.passWord.text];
        return [RACSignal empty];
    }];
    
    /**
     *  <#Description#>
     *
     *  @param self                     <#self description#>
     *  @param self.loginButton.enabled <#self.loginButton.enabled description#>
     *
     *  @return <#return value description#>
     */
    RAC(self, self.loginButton.enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal, self.passWord.rac_textSignal] reduce:^id(NSString *userName, NSString *passWord){
        return @(userName.length>=5 && passWord.length>=5);
    }];
    
    
}

@end
