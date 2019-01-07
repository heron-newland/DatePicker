# DatePicker

![](https://github.com/heron-newland/DatePicker/blob/master/Icon.png)

一款简单的iOS系统风格的日期选择器, 使用windwo作为容器,能自定义外观, 使用block回调事件,简单易用.

## 支持环境

- iOS8.0及以上版本
- Swift 或者 OC

## 集成方法

### OC
- 将 `HRDatePickerWindow` 文件夹拖入工程即可

### Swift
- 将 `HRDatePickerWindow` 文件夹拖入工程
- 在Swift与OC的桥接文件中使用 `#import "HRDatePickerWindow.h"` 导入头文件


## 效果如下图

![图片](https://github.com/heron-newland/DatePicker/blob/master/datePicker.png)
	

## 使用方式

### OC

- 导入头文件
- 在需要使用的类里面声明一个强引用属性， 或者声明一个成员变量如下
	
		 @property (nonatomic, strong) HRDatePickerWindow *datePicker{
			 HRDatePickerWindow * _datePicker;
		 }
	 
	 
-  中初始化(一般在`viewDidLoad`中)： 

		_datePicker = [[HRDatePickerWindow alloc] init];

-  在需要显示的地方调用show方法

 		[_datePicker show];
 	
## 此日期选择器所有属性和方法如下
 
> @interface HRDatePickerWindow : UIWindow
 
> @property (nonatomic, strong) UIDatePicker *datePicker;
	
> @property (nonatomic, strong) NSDate *maximumDate;//最大日期
	
> @property (nonatomic, strong) NSDate *minimumDate;//最小日期
	
> @property (nonatomic, strong) NSDate *nowDate;//初始化后默认显示当前日期
	
> @property (nonatomic, assign) HRDatePickerMode datePickerMode;//日期模式, 具体如下
	
		
>  模式|描述
---|---
HRDatePickerModeTime| 时,分,上午或下午`(e.g: 6 | 53 | PM)`
HRDatePickerModeDate|   年,月,日 `(e.g 11 | 15 | 2007)` 默认模式（default mode）
HRDatePickerModeDateAndTime| 星期, 年与日日, `(e.g Wed Nov 15 | 6 | 53 | PM)`
HRDatePickerModeCountDownTimer| 时分`(e.g 1 | 53)`
				
	
		
> @property (nonatomic, strong) UIColor *datePickerBackGroundColor;//datePicker的背景颜色
	
> @property (nonatomic, strong) UIColor *operationBackGroundColor;//datePicker上方view的背景颜色
	
> @property (nonatomic, strong) UIColor *maskColor;//遮罩层的颜色
	
> @property (nonatomic, assign)CGFloat datePickerHeight;//整个view的高度,如果初始化设置frame那么只有高度起作用
	
> @property (nonatomic, copy) commit commitBlock;//选中某个日期的回调
	
> @property (nonatomic, copy) cancel cancelBlock;//取消的回调
	
> @property (nonatomic, assign)BOOL showTodayButton;//是否显示回到今日的按钮
	
> -(void)show;//在指定界面展示日期选择器
 		

## 完整代码如下

### OC

		@interface DateSample ()
		//强引用
		@property(nonatomic, strong) HRDatePickerWindow *datePicker;
		@end
		@implementation DateSample
		
		- (void)viewDidLoad {
		    [super viewDidLoad];
		    // Do any additional setup after loading the view from its nib.
		}
		
		- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
			//显示日期选择器
			[self.datePicker show];
		}
		
		//懒加载
		- (HRDatePickerWindow *)datePicker{
		    if (!_datePicker) {
		        _datePicker = [[HRDatePickerWindow alloc] init];
		        _datePicker.datePickerMode = HRDatePickerModeDate;
		        _datePicker.operationBackGroundColor = kAppMainColor;
		        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
		        _datePicker.datePicker.locale = locale;
		        _datePicker.showTodayButton = YES;
		        __weak typeof(self) weakSelf = self;
		        _datePicker.commitBlock = ^(NSDate *date) {
		           //选定日期的回调, 处理如改变UI, 发送请求等业务逻辑
		            
		        };
		    }
		    return _datePicker;
		}
		
		@end


### Swift

	//懒加载
    private var datePick: HRDatePickerWindow = {
        let datePick = HRDatePickerWindow(frame: .zero)
        datePick.datePickerMode = HRDatePickerMode.date
       datePick.datePicker.locale = Locale(identifier: "zh_CN")
        datePick.showTodayButton = true
        return datePick
    }()
    
    //显示日期选择器
     func selectDate(_ sender: UIButton) {
        datePick.commitBlock = {[weak self] date in
            self?.inputValue.text = self?.formatter.string(from: date!)
        }
        datePick.show()
    }
    
 
    
## 联系方式

邮箱: objc_china@163.com
