//
//  VerifyViewController.m
//  SKLockViewDemo
//
//  Created by Alexander on 2018/2/5.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "VerifyViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "SKLockView.h"
@interface VerifyViewController ()

@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	

	
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
		// 如果是第二次设置的话 可以将选中的结果 对比 第一次的结果 是否一致
		if ([weakSelf.selectStr isEqualToString:resultStr]) {
						UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"设置成功" preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				[weakSelf dismissViewControllerAnimated:YES completion:nil];
			}];
			[alert addAction:ac1];
			
			[weakSelf presentViewController:alert animated:YES completion:nil];
		}else{
		
				UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证不对的" preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				[weakSelf dismissViewControllerAnimated:YES completion:nil];
			}];
			[alert addAction:ac1];
			
			[weakSelf presentViewController:alert animated:YES completion:nil];
		}
		
	};
	// lockView.backgroundColor = [UIColor clearColor];
	[bgView addSubview:lockView];
	
	
	self.view.backgroundColor = [UIColor whiteColor];
	UILabel *showLbl = [[UILabel alloc]init];
	showLbl.backgroundColor = [UIColor brownColor];
	showLbl.text = @"第二步 验证手势";
	showLbl.textAlignment = NSTextAlignmentCenter;
	showLbl.frame = CGRectMake(0, 100, SCREEN_WIDTH, 50);
	[self.view addSubview:showLbl];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
