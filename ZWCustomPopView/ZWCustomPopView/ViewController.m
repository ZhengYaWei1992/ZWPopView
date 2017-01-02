//
//  ViewController.m
//  ZWCustomPopView
//
//  Created by 郑亚伟 on 16/9/19.
//  Copyright © 2016年 郑亚伟. All rights reserved.
//

#import "ViewController.h"
#import "ZWCustomPopView.h"


#define RGBCOLOR(r,g,b)		[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<ZWCustomPopViewDelegate>
{
    UIButton *_rightBtn;
    
    UIButton *_leftBtn;
    
    NSArray *_titles;
}

@property(nonatomic,strong)ZWCustomPopView *pView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromHex(0x222222); // 背景色
     self.navigationController.navigationBar.translucent = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame= CGRectMake(0, 0, 40, 40);
    [btn setImage:[[UIImage imageNamed:@"option"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: btn_right, nil];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn2.frame = CGRectMake(100, 100, 50, 50);
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btnClick:(UIButton *)btn{
    UIButton *contentBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    contentBtn.bounds = CGRectMake(0, 0, 60, 40);
    _pView = [ZWCustomPopView popOverView];
    _pView.content = contentBtn;
    [contentBtn addTarget:self action:@selector(contentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_pView showFrom:btn alignStyle:CPAlignStyleCenter];
}
- (void)contentBtnClick{
    NSLog(@"%s",__func__);
    [_pView dismiss];
}



- (void)optionClick:(UIButton *)sender{
    
    NSArray *menus = @[@"发起群聊", @"添加朋友",@"扫一扫",@"收付款"];
    //这里的44是tableView的行高
    ZWCustomPopView *pView = [[ZWCustomPopView alloc]initWithBounds:CGRectMake(0, 0, 120, 44 * menus.count) titleMenus:menus maskAlpha:0.0];
    pView.delegate = self;
    pView.containerBackgroudColor = RGBCOLOR(0, 100, 14);//可以用来调节边界线的颜色
    [pView showFrom:sender alignStyle:CPAlignStyleRight];
}



#pragma mark- CustomPopOverViewDelegate
- (void)popOverViewDidShow:(ZWCustomPopView *)pView
{
    NSLog(@"popOverViewDidShow");
}
- (void)popOverViewDidDismiss:(ZWCustomPopView *)pView
{
    NSLog(@"popOverViewDidDismiss");
}

- (void)popOverView:(ZWCustomPopView *)pView didClickMenuIndex:(NSInteger)index
{
     NSArray *menus = @[@"发起群聊", @"添加朋友",@"扫一扫",@"收付款"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"你点击了: %@", menus[index]] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

@end
