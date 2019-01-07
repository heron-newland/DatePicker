//
//  HRDatePickerWindow.m
//  datePickerTest
//
//  Created by  bochb on 17/2/14.
//  Copyright © 2017年 boc. All rights reserved.
//

#import "HRDatePickerWindow.h"

#define FunctionViewHeight SHeight * 0.35//日期选择器的总高度
#define OperationViewHeight 30//按钮区域的高度

@interface HRDatePickerWindow ()

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSDate *tempDate;
@property (nonatomic, strong) UIView *functionView;
@property (nonatomic, strong) UIView *operationView;
@end
@implementation HRDatePickerWindow
 static  CGFloat buttonWidth = 60;//按钮宽度(button width)
- (instancetype)init {
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}
- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, SWidth, SHeight);
    
    if (self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelAlert + 1;
        [self makeKeyAndVisible];
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];
        
        //        self.alpha = _maskAlpha ? _maskAlpha: 0.4;
        self.opaque = YES;
        NSLog(@"%f",self.datePickerHeight);
        _functionView = [[UIView alloc] initWithFrame:CGRectMake(0, SHeight, SWidth, _datePickerHeight ? _datePickerHeight : FunctionViewHeight)];
        _functionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_functionView];
        [self configureOperationView];
        [self configureDatePicker];
        //        self.hidden = YES;
        self.alpha = 0;
    }
    return self;
}

#pragma mark - 设置整个日期选择器的高度   (set the total datePickerHeight)
- (void)setDatePickerHeight:(CGFloat)datePickerHeight {
    _datePickerHeight = datePickerHeight;
    self.datePicker.frame = CGRectMake(0, OperationViewHeight, SWidth, (_datePickerHeight ? _datePickerHeight : FunctionViewHeight) - OperationViewHeight);
}
- (void)setNowDate:(NSDate *)nowDate {
    _nowDate = nowDate;
    self.datePicker.date = _nowDate ? _nowDate : [NSDate date];
}
- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = _maximumDate;
}

- (void)setDatePickerMode:(HRDatePickerMode)datePickerMode {
    _datePickerMode = datePickerMode;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}
- (void)setDatePickerBackGroundColor:(UIColor *)datePickerBackGroundColor {
    _datePickerBackGroundColor = datePickerBackGroundColor;
    self.datePicker.backgroundColor = _datePickerBackGroundColor ? _datePickerBackGroundColor : [UIColor whiteColor];
}
-(void)setOperationBackGroundColor:(UIColor *)operationBackGroundColor {
    _operationBackGroundColor = operationBackGroundColor;
    _operationView.backgroundColor = _operationBackGroundColor? _operationBackGroundColor: [UIColor colorWithRed:97 / 255.0 green:165/255.0 blue:246 / 255.0 alpha:1];
}
- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    self.backgroundColor = _maskColor ? _maskColor : [UIColor colorWithWhite:0.8 alpha:0.4];
}
- (void)setShowTodayButton:(BOOL)showTodayButton {
    _showTodayButton = showTodayButton;
    if (showTodayButton) {
        
        UIButton *todayButton = [[UIButton alloc] initWithFrame:CGRectMake((SWidth - buttonWidth * 2) * 0.5, 0, buttonWidth * 2, OperationViewHeight)];
        [self.operationView addSubview:todayButton];
        
        [todayButton setTitle:@"回到今天" forState:UIControlStateNormal];
        [todayButton addTarget:self action:@selector(showToday) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark - datePicker的UI   (configure datePicker UI)
- (void)configureDatePicker {
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, OperationViewHeight, SWidth,  FunctionViewHeight - OperationViewHeight)];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.date = [NSDate date];
    [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_functionView addSubview:self.datePicker];
}
#pragma mark - 按钮区域UI  (configure operation area UI)
- (void)configureOperationView {
    CGFloat buttonWidth = 60;//按钮宽度(button width)
    CGFloat margin = 10;//按钮距离屏幕边界的距离(margin between screen boundary and button)
    
    self.operationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWidth, _datePickerHeight ? _datePickerHeight : FunctionViewHeight)];
    _operationView.backgroundColor = [UIColor colorWithRed:97 / 255.0 green:165/255.0 blue:246 / 255.0 alpha:1];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(margin, 0, buttonWidth, OperationViewHeight)];
    UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(SWidth - buttonWidth - margin, 0, buttonWidth, OperationViewHeight)];
    [_operationView addSubview:cancelButton];
    [_operationView addSubview:commitButton];
    [_functionView addSubview:_operationView];
    
    //设置按钮区的背景颜色（set the background color of operation arear）
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    CGPoint convered =[self convertPoint:curP toView:_functionView];
    
    if (!CGRectContainsPoint(_functionView.bounds, convered)) {
        NSLog(@"点击遮罩层取消");
        [self dimiss];
    }
}
#pragma mark - 事件响应
- (void)showToday {
    [self.datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:0] animated:YES];
}
//datepicker日期改变事件
- (void)datePickerValueChanged:(UIDatePicker *)sender {
    NSLog(@"%@",sender.date);
    //    self.currentDate = sender.date;
    
}
//取消按钮的点击时间
- (void)cancelAction: (UIButton *)sender {
    NSLog(@"取消");
    [self dimiss];
}
//确定按钮的点击时间
- (void)commitAction: (UIButton *)sender {
    NSLog(@"确定");
    //    self.tempDate = self.currentDate;
    [self dimiss];
    if (self.commitBlock) {
        self.commitBlock(self.datePicker.date);
    }
    
}

- (void)show {
    
    [UIView animateWithDuration:0.25 animations:^{
        _functionView.frame = CGRectMake(0, SHeight - (_datePickerHeight ? _datePickerHeight : FunctionViewHeight), SWidth, _datePickerHeight ? _datePickerHeight : FunctionViewHeight);
        self.alpha = 1;
    }];
}
- (void)dimiss {
    NSLog(@"%f",_datePickerHeight ? _datePickerHeight : FunctionViewHeight);
    //键盘消失
    [UIView animateWithDuration:0.25 animations:^{
        _functionView.frame = CGRectMake(0, SHeight, SWidth, _datePickerHeight ? _datePickerHeight : FunctionViewHeight);
        self.alpha = 0;
    }];
}


@end
