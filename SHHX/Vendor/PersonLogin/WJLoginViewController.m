//
//  WJLoginViewController.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/12.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJLoginViewController.h"
#import "WJRegisterViewController.h"
#import "WJForgetViewController.h"
#import "AppDelegate+WJCategory.h"

@interface WJLoginViewController ()

@property (strong,nonatomic)UIImageView                         *bgImageView;

@property (strong,nonatomic)UIView                              *inputBgView;

@property (strong,nonatomic)UITextField                         *pwdTF;

@property (strong,nonatomic)UITextField                         *userTF;

@property (strong,nonatomic)UIButton                            *QQBtn;

@property (strong,nonatomic)UIButton                            *WXBtn;

@property (strong,nonatomic)UIButton                            *XLBtn;

@property (copy  ,nonatomic)NSString                            *pwdStr;

@property (copy  ,nonatomic)NSString                            *userStr;

@end

@implementation WJLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.bgImageView.image=[UIImage imageNamed:@"bg4"];
    [self.view addSubview:self.bgImageView];
    
    //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 27, 35, 35)];
    [but setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *zhuce =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 30, 50, 30)];
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    [zhuce.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    
    UILabel *lanel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 30, 50, 30)];
    lanel.text=@"登录";
    lanel.textColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    [self.view addSubview:lanel];
    
    
    [self createButtons];
    [self createImageViews];
    [self createTextFields];
    [self createLabel];
    
}

#pragma mark -点击返回按钮-
-(void)clickaddBtn:(UIButton *)btn{

    WJLog(@"点击返回");
}

#pragma mark -点击登录按钮-
-(void)landClick{
    
    WJLog(@"点击登录");
//    if ([self.userTF.text isEqualToString:@""])
//    {
//        //[SVProgressHUD showInfoWithStatus:@"亲,请输入用户名"];
//        return;
//    }
//    else if (self.userTF.text.length <11)
//    {
//        //[SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
//        return;
//    }
//    else if ([self.pwdTF.text isEqualToString:@""])
//    {
//        //[SVProgressHUD showInfoWithStatus:@"亲,请输入密码"];
//        return;
//    }
//    else if (self.pwdTF.text.length <6)
//    {
//        //[SVProgressHUD showInfoWithStatus:@"亲,密码长度至少六位"];
//        return;
//    }
    
#warning -1代表登录登录成功-
    if (1) {
        NSString *token = @"666";
        [NSUserDefaults saveUserDefaultObject:token key:@"token"];
        [(AppDelegate *)[UIApplication sharedApplication].delegate setRootController];
        [HXUserInfo mj_objectWithKeyValues:@{@"name":@"张三",@"age":@"18",@"gender":@"女"}];
        [NSKeyedArchiver saveArchiveRootObject:[HXUserInfo shareUserBase] toFile:kFilePathCache(@"userInfo")];
        HXUserInfo *user = [NSKeyedArchiver getArchiveRootObjectWithFilePath:kFilePathCache(@"userInfo")];
        WJLog(@"name = %@,age = %@",user.name,user.age);
        
    //登录失败
    }else{
        //提示信息
    }
}

#pragma mark -点击导航栏注册-
- (void)zhuce{
    WJLog(@"注册");
    [self.navigationController pushViewController:[WJRegisterViewController new] animated:YES];
}

#pragma mark -点击快速注册-
- (void)registration:(UIButton *)button{
    WJLog(@"快速注册");
    [self.navigationController pushViewController:[[WJRegisterViewController alloc]init] animated:YES];
}

#pragma mark -点击忘记密码-
- (void)fogetPwd:(UIButton *)button{
    [self.navigationController pushViewController:[[WJForgetViewController alloc]init] animated:YES];
    WJLog(@"fogetPwd");
}


- (void)onClickQQ:(UIButton *)button{
    
    
}

- (void)onClickWX:(UIButton *)button{
    
    
}


- (void)onClickSina:(UIButton *)button{
    
    
}

-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.userTF resignFirstResponder];
    [self.pwdTF resignFirstResponder];
}

-(void)createButtons{
    UIButton *loginBtn=[self createButtonFrame:CGRectMake(10, 190, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(landClick)];
    loginBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    loginBtn.layer.cornerRadius=5.0f;
    
    UIButton *fastRegistBtn=[self createButtonFrame:CGRectMake(5, 235, 70, 30) backImageName:nil title:@"快速注册" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(registration:)];
    //newUserBtn.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(fogetPwd:)];
    //fogotPwdBtn.backgroundColor=[UIColor lightGrayColor];
    
    
#define Start_X 60.0f           // 第一个按钮的X坐标
#define Start_Y 440.0f           // 第一个按钮的Y坐标
#define Width_Space 50.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 50.0f    // 高
#define Button_Width 50.0f      // 宽
    
    
    
    //微信
    self.WXBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 440, 50, 50)];
    //weixinBtn.tag = UMSocialSnsTypeWechatSession;
    self.WXBtn.layer.cornerRadius=25;
    self.WXBtn = [self createButtonFrame:self.WXBtn.frame backImageName:@"ic_landing_wechat" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX:)];
    //qq
    self.QQBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2-100, 440, 50, 50)];
    //QQBtn.tag = UMSocialSnsTypeMobileQQ;
    self.QQBtn.layer.cornerRadius=25;
    self.QQBtn = [self createButtonFrame:self.QQBtn.frame backImageName:@"ic_landing_qq" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ:)];
    
    //新浪微博
    self.XLBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2+100, 440, 50, 50)];
    //xinlangBtn.tag = UMSocialSnsTypeSina;
    self.XLBtn.layer.cornerRadius=25;
    self.XLBtn=[self createButtonFrame:self.XLBtn.frame backImageName:@"ic_landing_microblog" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina:)];
    
//    [self.view addSubview:self.WXBtn];
//    [self.view addSubview:self.QQBtn];
//    [self.view addSubview:self.XLBtn];
    [self.view addSubview:loginBtn];
    [self.view addSubview:fastRegistBtn];
    [self.view addSubview:forgotPwdBtn];
    
    
}

-(void)createImageViews{
    
    UIImageView *line3=[self createImageViewFrame:CGRectMake(2, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
    UIImageView *line4=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
//    [self.view addSubview:line3];
//    [self.view addSubview:line4];
}

-(void)createTextFields
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.inputBgView = [[UIView alloc]initWithFrame:CGRectMake(10, 75, frame.size.width-20, 100)];
    self.inputBgView.layer.cornerRadius=3.0;
    self.inputBgView.alpha=0.7;
    self.inputBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.inputBgView];
    
    self.userTF = [self createTextFielfFrame:CGRectMake(60, 10, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
    //user.text=@"13419693608";
    self.userTF.keyboardType = UIKeyboardTypeNumberPad;
    self.userTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.pwdTF = [self createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
    self.pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    //pwd.text=@"123456";
    //密文样式
    self.pwdTF.secureTextEntry = YES;
    //pwd.keyboardType=UIKeyboardTypeNumberPad;
    
    
    UIImageView *userImageView = [self createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    UIImageView *pwdImageView = [self createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"mm_normal" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, self.inputBgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [self.inputBgView addSubview:self.userTF];
    [self.inputBgView addSubview:self.pwdTF];
    
    [self.inputBgView addSubview:userImageView];
    [self.inputBgView addSubview:pwdImageView];
    [self.inputBgView addSubview:line1];
}

-(void)createLabel
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, 390, 140, 21)];
    label.text=@"第三方账号快速登录";
    label.textColor=[UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
//    [self.view addSubview:label];
}

-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    if (imageName){
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color){
        imageView.backgroundColor=color;
    }
    return imageView;
}


-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}



@end
