//
//  HYStepper.m
//  HYStepper
//
//  Created by zhuxuhong on 2017/7/16.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import "HYStepper.h"


@interface HYStepper()

@property(nonatomic,copy)UIButton *minusBtn;
@property(nonatomic,copy)UIButton *plusBtn;
@property(nonatomic,copy)UITextField *valueTF;

@end

@implementation HYStepper

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self initData];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initData];
        
        [self setupUI];
    }
    return self;
}

-(void)initData{
    _isValueEditable = true;
    _stepValue = 1;
    _minValue = 0;
    _maxValue = 100;
    
    self.value = 0;
}

-(void)setupUI{
    self.translatesAutoresizingMaskIntoConstraints = false;

    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    
    [self addSubview: self.minusBtn];
    [self addSubview: self.plusBtn];
    [self addSubview: self.valueTF];
    
    [self setupLayout];
}

-(void)setupLayout{
    NSDictionary *views = NSDictionaryOfVariableBindings(_minusBtn, _plusBtn, _valueTF);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_minusBtn(44)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_minusBtn]|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_plusBtn(_minusBtn)]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_plusBtn]|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_valueTF]|" options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_valueTF attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_minusBtn attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_valueTF attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_plusBtn attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
}

#pragma mark - action
-(void)actionForButtonClicked: (UIButton*)sender{
    if ([sender isEqual:_minusBtn]) {
        self.value = _value - _stepValue;
    }
    else if([sender isEqual:_plusBtn]){
        self.value = _value + _stepValue;
    }
}

-(void)actionForTextFieldValueChanged: (UITextField*)sender{
    if ([sender isEqual:_valueTF]) {
        self.value = [sender.text doubleValue];
    }
}


#pragma mark - setters
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

-(void)setMaxValue:(double)maxValue{
    if (maxValue < _minValue) {
        maxValue = _minValue;
    }
    _maxValue = maxValue;
}

-(void)setMinValue:(double)minValue{
    if (minValue > _maxValue) {
        minValue = _maxValue;
    }
    _minValue = minValue;
}

-(void)setIsValueEditable:(BOOL)isValueEditable{
    _isValueEditable = isValueEditable;
    
    _valueTF.enabled = _isValueEditable;
}

#pragma mark - private
-(UIButton*)actionButtonWithTitle: (NSString*)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    btn.tintColor = [UIColor darkTextColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionForButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


#pragma mark - getters
-(UITextField *)valueTF{
    if (!_valueTF) {
        UITextField *tf = [UITextField new];
        tf.font = [UIFont systemFontOfSize:16];
        [tf addTarget:self action:@selector(actionForTextFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        tf.borderStyle = UITextBorderStyleNone;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.enabled = self.isValueEditable;
        tf.translatesAutoresizingMaskIntoConstraints = false;
        tf.text = [NSString stringWithFormat:@"%.0f",self.value];
        
        _valueTF = tf;
    }
    return _valueTF;
}

-(UIButton *)minusBtn{
    if (!_minusBtn) {
        UIButton *btn = [self actionButtonWithTitle:@"-"];
        btn.translatesAutoresizingMaskIntoConstraints = false;

        _minusBtn = btn;
    }
    return _minusBtn;
}

-(UIButton *)plusBtn{
    if (!_plusBtn) {
        UIButton *btn = [self actionButtonWithTitle:@"+"];
        btn.translatesAutoresizingMaskIntoConstraints = false;

        _plusBtn = btn;
    }
    return _plusBtn;
}

@end
