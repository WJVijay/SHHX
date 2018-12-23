
//
//  WJRegisterViewController.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/12.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJRegisterViewController.h"
#import "WJSetPWDViewController.h"

@interface WJRegisterViewController ()

@property (strong,nonatomic)UIView                         *bgView;

@property (strong,nonatomic)UITextField                    *phone;

@property (strong,nonatomic)UITextField                    *code;

@property (strong,nonatomic)UINavigationBar                *cumstomNavBar;

@property (strong,nonatomic)UIButton                       *yzButton;

@property (copy  ,nonatomic)NSString                       *userPhoneNum;

@property (assign,nonatomic)NSInteger                      timeCount;

//定时器
@property (strong,nonatomic)NSTimer                        *timer;

//验证码
@property (copy  ,nonatomic)NSString                       *iphoneCode;

@end

@implementation WJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#warning -快速注册一-
    self.title=@"注册1/3";
    self.navigationController.navigationBarHidden = NO;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(clickaddBtn)];
    [addBtn setImage:[UIImage imageNamed:@"goback_back_orange_on"]];
    [addBtn setImageInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    addBtn.tintColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    [self.navigationItem setLeftBarButtonItem:addBtn];
    
    [self createTextFields];
    
}

-(void)clickaddBtn
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:[[MMZCViewController alloc]init] animated:YES];
}

-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    
    [self.view addSubview:label];
    
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 100)];
    self.bgView.layer.cornerRadius = 3.0;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.phone=[self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"11位手机号"];
    self.phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phone.keyboardType = UIKeyboardTypeNumberPad;
    
    //phone.text=@"15527002684";
    
    self.code=[self createTextFielfFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"4位数字" ];
    self.code.clearButtonMode = UITextFieldViewModeWhileEditing;
    //code.text=@"mojun1992225";
    //密文样式
    self.code.secureTextEntry = YES;
    self.code.keyboardType = UIKeyboardTypeNumberPad;
    
    
    UILabel *phonelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text = @"手机号";
    phonelabel.textColor = [UIColor blackColor];
    phonelabel.textAlignment = NSTextAlignmentLeft;
    phonelabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *codelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    codelabel.text = @"验证码";
    codelabel.textColor = [UIColor blackColor];
    codelabel.textAlignment = NSTextAlignmentLeft;
    codelabel.font = [UIFont systemFontOfSize:14];
    
    
    self.yzButton=[[UIButton alloc]initWithFrame:CGRectMake(self.bgView.frame.size.width-100-20, 62, 100, 30)];
    //yzButton.layer.cornerRadius=3.0f;
    //yzButton.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [self.yzButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    [self.yzButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.yzButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.yzButton];
    
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, self.bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    UIButton *landBtn=[self createButtonFrame:CGRectMake(10, self.bgView.frame.size.height+self.bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"下一步" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(next)];
    landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    landBtn.layer.cornerRadius=5.0f;
    
    
    [self.bgView addSubview:self.phone];
    [self.bgView addSubview:self.code];
    
    [self.bgView addSubview:phonelabel];
    [self.bgView addSubview:codelabel];
    [self.bgView addSubview:line1];
    [self.view addSubview:landBtn];
    
}

- (void)getValidCode:(UIButton *)sender
{
    if ([self.phone.text isEqualToString:@""])
    {
        return;
    }
    else if (self.phone.text.length <11)
    {
        return;
    }
    self.userPhoneNum = self.phone.text;
    //__weak MMZCHMViewController *weakSelf = self;
    sender.userInteractionEnabled = NO;
    self.timeCount = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
    
}

- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.yzButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.yzButton.userInteractionEnabled = YES;
        [self.timer invalidate];
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [self.yzButton setTitle:str forState:UIControlStateNormal];
         self.yzButton.userInteractionEnabled = NO;
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phone resignFirstResponder];
    
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
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
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

//验证码
-(void)next
{
    
    //    if ([phone.text isEqualToString:@""])
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
    //        return;
    //    }
    //    else if (phone.text.length <11)
    //    {
    //        ///[SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
    //        return;
    //    }
    //    else if ([code.text isEqualToString:@""])
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"亲,请输入验证码"];
    //        return;
    //    }
    //    else if (self.smsId.length == 0)
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"验证码错误"];
    //        return;
    //   }
    
    [self.navigationController pushViewController:[[WJSetPWDViewController alloc]init] animated:YES];
    
}




@end
