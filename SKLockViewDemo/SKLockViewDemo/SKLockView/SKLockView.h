//
//  SKLockView.h
//  SKLockViewDemo
//
//  Created by Alexander on 2018/2/4.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 定义一个Block 回传绘制结果 */
typedef void(^LockResultBtnBlock)(NSString *resultStr);

@interface SKLockView : UIView

/** 持有block */
@property (nonatomic,copy)LockResultBtnBlock lockBlock;


@end
