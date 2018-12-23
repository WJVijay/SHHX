
//
//  WJSetPWDViewController.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/12.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "WJSetPWDViewController.h"
#import "WJSetPWDViewController.h"

@interface WJSetPWDViewController ()

@property (strong,nonatomic)UIView                         *bgView;

@property (strong,nonatomic)UITextField                    *password;

@end

@implementation WJSetPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"注册2/3";
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(clickaddBtn)];
    [addBtn setImage:[UIImage imageNamed:@"goback_back_orange_on"]];
    [addBtn setImageInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    addBtn.tintColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    [self.navigationItem setLeftBarButtonItem:addBtn];
    
    [self createTextFields];
    
}

-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请设置密码";
    label.textColor=[UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:label];

    CGRect frame = [UIScreen mainScreen].bounds;
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 50)];
    self.bgView.layer.cornerRadius=3.0;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bgView];

    self.password=[self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"6-20位字母或数字"];
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password.secureTextEntry=YES;

    UILabel *phonelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text = @"密码";
    phonelabel.textColor = [UIColor blackColor];
    phonelabel.textAlignment = NSTextAlignmentLeft;
    phonelabel.font = [UIFont systemFontOfSize:14];

    UIButton *landBtn = [self createButtonFrame:CGRectMake(10, self.bgView.frame.size.height+self.bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"下一步" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(landClick)];
    landBtn.backgroundColor = [UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    landBtn.layer.cornerRadius = 5.0f;

    [self.bgView addSubview:self.password];

    [self.bgView addSubview:phonelabel];
    [self.view addSubview:landBtn];
}

-(void)landClick
{
    //    if([passward.text isEqualToString:@""])
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"您还未设置密码"];
    //        return;
    //    }
    //    else if (passward.text.length <6)
    //    {
    //        //[SVProgressHUD showInfoWithStatus:@"亲,密码长度至少六位"];
    //        return;
    //    }
    [self.navigationController pushViewController:[[WJSetPWDViewController alloc]init] animated:YES];
//    [CheckTools savePassword:passward.text];
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

-(void)clickaddBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
