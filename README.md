# HYStepper
A customized stepper component is same as UIStepper in OC.

![最终效果](http://upload-images.jianshu.io/upload_images/1334681-e2aedca4e2a684b7.gif?imageMogr2/auto-orient/strip)

##### 要求：
- Platform: iOS7.0+ 
- Language: OC
- Editor: Xcode6.0+

##### 实现

- 思路

**UIButton + UITextField + UIButton + NSLayoutConstraint**

- 核心代码

**1. setters**

```
#pragma mark - setters

// 当前值
-(void)setValue:(double)value{
    if (value < _minValue) {
        value = _minValue;
    }
    else if (value > _maxValue){
        value = _maxValue;
    }
    
    _minusBtn.enabled = value > _minValue;
    _plusBtn.enabled = value < _maxValue;
    _valueTF.text = [NSString stringWithFormat:@"%.0f",value];
        
    _value = value;
    
    _valueChanged ? _valueChanged(_value) : nil;
}

// 最大值
-(void)setMaxValue:(double)maxValue{
    if (maxValue < _minValue) {
        maxValue = _minValue;
    }
    _maxValue = maxValue;
}

// 最小值
-(void)setMinValue:(double)minValue{
    if (minValue > _maxValue) {
        minValue = _maxValue;
    }
    _minValue = minValue;
}

// 是否可输入值
-(void)setIsValueEditable:(BOOL)isValueEditable{
    _isValueEditable = isValueEditable;
    
    _valueTF.enabled = _isValueEditable;
}
```

**2. 事件处理**

```
#pragma mark - action
// 按钮点击
-(void)actionForButtonClicked: (UIButton*)sender{
    if ([sender isEqual:_minusBtn]) {
        self.value = _value - _stepValue;
    }
    else if([sender isEqual:_plusBtn]){
        self.value = _value + _stepValue;
    }
}

// 输入事件
-(void)actionForTextFieldValueChanged: (UITextField*)sender{
    if ([sender isEqual:_valueTF]) {
        self.value = [sender.text doubleValue];
    }
}
```
- 用法: **支持xib和initWithFrame**

```
- (void)viewDidLoad {
    [super viewDidLoad];

// 值改变回调
    _stepper.valueChanged = ^(double value) {
        _label.text = [NSString stringWithFormat:@"%.f",value];
    };
}
```

### 简书
http://www.jianshu.com/p/918c7bd20fb0
> 如果对你有帮助，别忘了点个❤️哦。
