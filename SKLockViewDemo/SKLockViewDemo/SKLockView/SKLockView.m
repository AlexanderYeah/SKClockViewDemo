//
//  SKLockView.m
//  SKLockViewDemo
//
//  Created by Alexander on 2018/2/4.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "SKLockView.h"

@interface SKLockView()

/** 存放的都是当前选中的按钮 */
@property (nonatomic, strong) NSMutableArray *selectBtnArray;

/** 当前手指所在的点 实现线跟随手指滑动的效果 */
@property (nonatomic, assign) CGPoint curPoint;

@end


@implementation SKLockView


-(NSMutableArray *)selectBtnArray {
	
    if (_selectBtnArray == nil) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}

/** 连线
 	根据btn 的frame 进行连线

 */
- (void)drawRect:(CGRect)rect
{

	
	if (self.selectBtnArray.count) {
    	// 路径
	UIBezierPath *path = [UIBezierPath bezierPath];
	for (int i = 0; i < self.selectBtnArray.count; i++) {
		UIButton *btn = self.selectBtnArray[i];
		
		// 第一个btn 为起点
		if (i == 0) {
			[path moveToPoint:btn.center];
		}else{
			[path addLineToPoint:btn.center];
		}
	}
	
	// 将线画到手指的位置
	[path addLineToPoint:self.curPoint];
	
	// 线的颜色
	[[UIColor whiteColor] set];
	path.lineWidth = 5.0f;
	// 绘制
	[path stroke];
	path.lineJoinStyle =  kCGLineJoinRound;
}
	
	
}


- (instancetype)initWithFrame:(CGRect)frame
{

	if (self = [super initWithFrame:frame]) {
		// 搭建内部的UI
		[self createUI];
		// MARK: 此处一定要设置其背景颜色 否则的话，view 背景色为heise
		// 划线的过程一目了然
		 self.backgroundColor = [UIColor clearColor];
		
		
	}
	return self;
}

#pragma mark - 创建UI
/**
	绘制图案的记录其实就是记录按钮选中的顺序
	当手指离开的时候就要记录到本地
*/
- (void)createUI
{
	    for (int i = 0; i < 9; i++) {
			
        //创建按钮
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
			
        btn.userInteractionEnabled = NO;
		btn.tag = 666 + i;
        //设置按钮图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        //设置选中状态下的图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
			
        [self addSubview:btn];
			
    }

}

#pragma mark -  layout subview 的时候进行布局
- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat btn_w = 74;
	int maxCols = 3;
	CGFloat btn_padding = (self.bounds.size.width - maxCols *btn_w) / (maxCols + 1);
	
	for (int i = 0; i < self.subviews.count; i ++) {
		// 取出每一个btn 进行布局
		UIButton *btn = self.subviews[i];
		int row = i / maxCols;
		int col = i % maxCols;
		btn.frame = CGRectMake((btn_padding + btn_w) * col + btn_padding, (btn_padding + btn_w) * row + btn_padding, btn_w, btn_w);
	}
	

}


#pragma mark -  触摸事件
/**
	此方法是手指点击view的时候进行调用
	手指开始点击的时候 就要判断是否在btn 上 ，在的话 btn设置为选中状态
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

	//当前的手指所在的点在不在按钮上, 如果在,让按钮成为选中状态
    //1.获取当前手指所在的点
    CGPoint curP = [self getCurrentPoint:touches];
    //2.判断curP在不在按钮身上
    UIButton *btn = [self btnRectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        //保存当前选中的按钮
        [self.selectBtnArray addObject:btn];
    }
	

}

/**
	手指移动的时候进行调用,移动带btn 上面的时候 其frame 也要进行相应的设置
*/
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

	
    //当前的手指所在的点在不在按钮上, 如果在,让按钮成为选中状态
    //1.获取当前手指所在的点
    CGPoint curP = [self getCurrentPoint:touches];
    //记录当前手指所在的点
    self.curPoint = curP;
    //2.判断curP在不在按钮身上
    UIButton *btn = [self btnRectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtnArray addObject:btn];
    }
    //重绘
    [self setNeedsDisplay];
	
}

/**
	手指离开的时候进行调用
 	将按钮的连接顺序保存到本地
*/
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	NSMutableString *recordStr = [NSMutableString string];
	// 手指离开 取消所有的选中效果
	for (UIButton *btn in self.selectBtnArray) {
		btn.selected = NO;
		[recordStr appendString:[NSString stringWithFormat:@"%ld-",btn.tag]];
	}
	
	// 清空
	[self.selectBtnArray removeAllObjects];
	[self setNeedsDisplay];
	
	// 选中的顺序
	NSLog(@"%@",recordStr);
	// 将选中的结果传递会控制器
	self.lockBlock((NSString *)recordStr);
	
	
	

}


#pragma mark - 方法抽取出来

//获取当前手指所在的点
- (CGPoint)getCurrentPoint:(NSSet *)touches {
	
    //1.获取当前手指所在的点
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];

}

//给定一个点,判断给定的点在不在按钮身上
//如果在按钮身,返回当前所在的按钮,如果不在,返回nil;
- (UIButton *)btnRectContainsPoint:(CGPoint)point {

    for (UIButton *btn in self.subviews) {
		
        if (CGRectContainsPoint(btn.frame, point)) {
            //让当前按钮成为选中状态
            //btn.selected = YES;
            return btn;
        }
		
    }
    return nil;
}

@end
