//
//  HRDatePickerWindow.h
//  datePickerTest
//
//  Created by  bochb on 17/2/14.
//  Copyright © 2017年 boc. All rights reserved.
//


/*
 使用方法：
 在需要使用的类里面声明一个强引用属性， 或者声明一个成员变量如下
 @property (nonatomic, strong) HRDatePickerWindow *datePicker
 
 {
 HRDatePickerWindow * _datePicker;
 }

 在viewDidLoad中初始化： 
 [[HRDatePickerWindow alloc] init];
 
 在需要显示的地方调用show方法
 [_datePicker show];
 
 */
#import <UIKit/UIKit.h>
#define SWidth [UIScreen mainScreen].bounds.size.width
#define SHeight [UIScreen mainScreen].bounds.size.height

//时间的显示模式  (time display modes)
typedef NS_ENUM(NSInteger, HRDatePickerMode) {
    HRDatePickerModeTime,           // 时,分,上午或下午(e.g: 6 | 53 | PM)
    HRDatePickerModeDate,           // 年,月,日 (e.g 11 | 15 | 2007) 默认模式（default mode）
    HRDatePickerModeDateAndTime,    // 星期, 年与日日, (e.g Wed Nov 15 | 6 | 53 | PM)
    HRDatePickerModeCountDownTimer, // 时分(e.g 1 | 53)
};

typedef void(^cancel)(void);
typedef void(^commit)(NSDate *date);

@interface HRDatePickerWindow : UIWindow
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *maximumDate;//最大日期
@property (nonatomic, strong) NSDate *minimumDate;//最小日期
@property (nonatomic, strong) NSDate *nowDate;//初始化后默认显示当前日期
@property (nonatomic, assign) HRDatePickerMode datePickerMode;
@property (nonatomic, strong) UIColor *datePickerBackGroundColor;//datePicker的背景颜色
@property (nonatomic, strong) UIColor *operationBackGroundColor;//datePicker上方view的背景颜色
@property (nonatomic, strong) UIColor *maskColor;//遮罩层的颜色
//@property (nonatomic, assign) CGFloat maskAlpha;//遮罩层的颜色的透明度
@property (nonatomic, assign)CGFloat datePickerHeight;//整个view的高度,如果初始化设置frame那么只有高度起作用
@property (nonatomic, copy) commit commitBlock;//选中某个日期的回调
@property (nonatomic, copy) cancel cancelBlock;//取消的回调
@property (nonatomic, assign)BOOL showTodayButton;//是否显示回到今日的按钮
- (void)show;//在指定界面展示日期选择器

@end
