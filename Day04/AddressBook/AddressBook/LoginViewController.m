//
//  ViewController.m
//  AddressBook
//
//  Created by QinTuanye on 2019/5/27.
//  Copyright © 2019 QinTuanye. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+Ex.h"
#import "SVProgressHUD.h"
#import "ContactViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField* usernameField;
@property (strong, nonatomic) IBOutlet UITextField* passwordField;
@property (strong, nonatomic) IBOutlet UIButton* loginButton;

@property (weak, nonatomic) IBOutlet UISwitch* remPassword;
@property (weak, nonatomic) IBOutlet UISwitch* autoLogin;

@end

@implementation LoginViewController

// 记住密码开关的切换
- (IBAction)remPasswordChange:(UISwitch*)sender
{
    // 如果关闭记住密码 那么同时关闭自动登录
    if (!sender.isOn) {
        //        self.autoLogin.on = NO;
        [self.autoLogin setOn:NO animated:YES];
    }
}

// 自动登录开关的切换
- (IBAction)autoLoginChange:(UISwitch*)sender
{
    // 如果开启自动登录 那么同时开启记住密码
    if (sender.isOn) {
        //        self.remPassword.on = YES;
        [self.remPassword setOn:YES animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 监听文本框
    [self.usernameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    // 监听登陆按钮
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self textChange];
}

// 登陆按钮的点击事件
- (void)login
{
    
    // 第三方框架 第三方库
    
    //        [MBProgressHUD showMessage:@"正在登陆"];
    [SVProgressHUD showWithStatus:@"正在登陆" maskType:SVProgressHUDMaskTypeBlack];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 隐藏
        //                [MBProgressHUD hideHUD];
        [SVProgressHUD dismiss];
        
        // 当用户名和密码正确的时候 进行跳转
        if ([self.usernameField.text isEqualToString:@"1"] && [self.passwordField.text isEqualToString:@"1"]) {
            // 跳!!!
            [self performSegueWithIdentifier:@"login2contact" sender:nil];
        }
        else {
            // 提示错误消息
            //                        [MBProgressHUD showError:@"用户名或密码错误"];
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        }
        
    });
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([@"login2contact" isEqualToString:identifier]) {
        return NO;
    }
    return YES;
}

// 只要走 sb 线都会调用
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    
    ContactViewController* contact = segue.destinationViewController;
    contact.username = self.usernameField.text;
}

// 文本框内容发生改变的时候调用
- (void)textChange
{
    //    if (self.usernameField.text.length > 0 && self.passwordField.text.length > 0) {
    //        // 两个文本框都有内容
    //        self.loginButton.enabled = YES;
    //    }
    //    else {
    //        // 两个文本框不都有内容
    //        self.loginButton.enabled = NO;
    //    }
    
    self.loginButton.enabled = self.usernameField.text.length > 0 && self.passwordField.text.length > 0;
}

- (void)这些都是文本框的代理方法
{
    
    // 是否允许这个文本框进行编辑
    //- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField
    //{
    //    NSLog(@"textFieldShouldBeginEditing");
    //    NSLog(@"%@", self.usernameField.text);
    //
    //    return NO;
    //}
    
    // 文本框已经开始编辑
    //- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //     NSLog(@"%@", self.usernameField.text);
    //}
    
    // 是否允许这个文本框结束编辑
    //- (BOOL)textFieldShouldEndEditing:(UITextField*)textField
    //{
    //    return NO;
    //}
    
    // 文本框已经结束编辑
    //- (void)textFieldDidEndEditing:(UITextField*)textField
    //{
    //    NSLog(@"123");
    //}
    
    // 是否允许文本框改变文字内容
    //- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
    //{
    //    NSLog(@"%@", self.usernameField.text);
    //    return NO;
    //
    //}
}

@end
