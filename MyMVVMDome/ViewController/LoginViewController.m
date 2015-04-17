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

@property (strong, nonatomic) LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    self.viewModel = [LoginViewModel new];
    
    /**
     *  当userName的text值长度大于3小于等于10的时候 输出值
     */
//    [[self.userName.rac_textSignal filter:^BOOL(NSString *text) {
//        return text.length>3&&text.length<=10;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    [[[self.userName.rac_textSignal map:^id(NSString *text) {
//        return @(text.length);
//    }] filter:^BOOL(NSNumber *length) {
//        return [length integerValue]>3;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    /*----------------------------------------------------------------------------*/
    /**
     *  检测用户名是否有效  有效字体黑色，反之红色
     */
    RACSignal *validUsernameSignal = [self.userName.rac_textSignal map:^id(NSString *value) {
        return @([self validText:value]);
    }];
//    [[validUsernameSignal map:^id(NSNumber *usernameValid) {
//        return [usernameValid boolValue] ? [UIColor blackColor]:[UIColor redColor];
//    }] subscribeNext:^(UIColor *backColor) {
//        self.userName.textColor = backColor;
//    }];
    //上面的代码等同于
    RAC(self.userName, textColor) = [validUsernameSignal map:^id(NSNumber *usernameValid) {
        return [usernameValid boolValue] ? [UIColor blackColor]:[UIColor redColor];
    }];
    
    
    /**
     *  检测密码是否有效 有效字体黑色，反之红色
     */
    RACSignal *validPasswordSingal = [self.passWord.rac_textSignal map:^id(NSString *value) {
        return @([self validText:value]);
    }];
//    [[validPasswordSingal map:^id(NSNumber *passwordValid) {
//        return [passwordValid boolValue] ? [UIColor blackColor]:[UIColor redColor];
//    }] subscribeNext:^(UIColor *backColor) {
//        self.passWord.textColor = backColor;
//    }];
    RAC(self.passWord, textColor) = [validPasswordSingal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor blackColor]:[UIColor redColor];
    }];
    
    
    
    /**
     *  聚合两个信号量，当都有效的时候，登录按钮才可以点击
     *
     *  @param usernameValid
     *  @param passwordValid
     *
     *  @return RACSignal
     */
    RACSignal *signUpSignal = [RACSignal combineLatest:@[validUsernameSignal,validPasswordSingal] reduce:^id (NSNumber *usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    //方法一
//    [signUpSignal subscribeNext:^(NSNumber *signupEnabled) {
//        self.loginButton.enabled = [signupEnabled boolValue];
//    }];
    //方法二
    RAC(self.loginButton,enabled) = [signUpSignal map:^id(NSNumber *value) {
        return @([value boolValue]);
    }];
    
    //flattenMap与map 的区别 flattenMap可以从内部信号发送事件到外部信号   doNext添加附加操作
    [[[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        self.loginButton.enabled = NO; //在登录逻辑过程中 设置按钮不可点击
    }] flattenMap:^RACStream *(id value) {
         return [self signInSignal];   //执行登录过程  并返回一个带有是否登录成功信号的信号量
    }]subscribeNext:^(NSNumber *signedIn) {
        self.loginButton.enabled = YES; //根据登录返回的信号量 做出处理
        BOOL success =[signedIn boolValue];
        if(success){
            [self.viewModel successLoginWithUserModel:nil withViewController:self];
        }
    }];
    
    /**
     *  忘记密码按钮
     */
    RACSignal *usernameLengthSignal = [self.userName.rac_textSignal map:^id(NSString *text) {
        return @(text.length>3);
    }];
    RAC(self.forgetPwdButton, enabled) = [usernameLengthSignal map:^id(NSNumber *forgetEnable) {
        return @([forgetEnable boolValue]);
    }];
    
    [[[[self.forgetPwdButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        self.forgetPwdButton.enabled = NO;
        NSLog(@"====%i",self.forgetPwdButton.enabled);
    }] flattenMap:^RACStream *(id value) {
        return [self forgetPasswordSignal];
    }] subscribeNext:^(NSArray *result) {
        self.forgetPwdButton.enabled = YES;
        BOOL success = [[result firstObject] boolValue];
        if (success) {
            NSString *message = [NSString stringWithFormat:@"您得密码是：%@",[result lastObject]];
            [[[UIAlertView alloc] initWithTitle:@"找回密码" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"找回密码" message:[result lastObject] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }
    }];
}

/**
 *  创建一个信号量 用来判断是否登录成功
 *
 *  @return RACSignal(里面包含着登录结果的signal)
 */
- (RACSignal *)signInSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.viewModel loginActionWithUserName:self.userName.text passWord:self.passWord.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

/**
 *  创建一个信号量 用来判断是否找回密码
 *
 *  @return RACSignal(里面包含着找回密码结果的signal)
 */
- (RACSignal *)forgetPasswordSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.viewModel forgetPasswordWithUsername:self.userName.text complete:^(BOOL success, NSString *pwd) {
            [subscriber sendNext:@[@(success),pwd]];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

/**
 *  是否有效
 *
 *  @param text
 *
 *  @return YES or NO
 */
- (BOOL)validText:(NSString *)text{
    if ([text isEqualToString:@"admin"]) {
        return YES;
    }
    return NO;
}

- (void)tapAction{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}

@end
