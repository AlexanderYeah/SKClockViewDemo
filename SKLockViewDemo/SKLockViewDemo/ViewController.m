//
//  ViewController.m
//  SKLockViewDemo
//
//  Created by Alexander on 2018/2/4.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "SKLockView.h"

#import "VerifyViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// lable
	

	
	// 背景view
	
	UIImageView *bgView = [[UIImageView alloc]init];
	bgView.userInteractionEnabled = YES;
	bgView.image = [UIImage imageNamed:@"Home_refresh_bg"];
	bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	[self.view addSubview:bgView];
	
	
	// 锁View
	CGFloat lock_w = SCREEN_WIDTH;
	SKLockView *lockView = [[SKLockView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - lock_w)/2, lock_w, lock_w)];
	lockView.userInteractionEnabled = YES;
	__weak typeof(self) weakSelf = self;
	lockView.lockBlock = ^(NSString *resultStr) {
		// 打印结果
		NSLog(@"打印结果 -- %@",resultStr);
		NSArray *resArr = [resultStr componentsSeparatedByString:@"-"];
		
		if (resArr.count < 5) {
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"最少连接5个点" preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				[weakSelf dismissViewControllerAnimated:YES completion:nil];
			}];
			[alert addAction:ac1];
			
			[weakSelf presentViewController:alert animated:YES completion:nil];
		}else{
			VerifyViewController *vc = [[VerifyViewController alloc]init];
			vc.selectStr = resultStr;
			[self presentViewController:vc
			 animated:YES completion:nil];
		
		}
		// 如果是第一次设置的话 可以将选中的结果存到本地
		
		
	};
	// lockView.backgroundColor = [UIColor clearColor];
	[bgView addSubview:lockView];
	
	UILabel *showLbl = [[UILabel alloc]init];
	showLbl.backgroundColor = [UIColor brownColor];
	showLbl.text = @"第一步 设置手势";
	showLbl.textAlignment = NSTextAlignmentCenter;
	showLbl.frame = CGRectMake(0, 100, SCREEN_WIDTH, 50);
	[self.view addSubview:showLbl];
	
	
	
	
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
