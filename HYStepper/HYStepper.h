//
//  HYStepper.h
//  HYStepper
//
//  Created by zhuxuhong on 2017/7/16.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HYStepperCallback)(double value);

@interface HYStepper : UIView

@property(nonatomic)BOOL isValueEditable;
@property(nonatomic)double minValue;
@property(nonatomic)double maxValue;
@property(nonatomic)double value;
@property(nonatomic)double stepValue;

@property(nonatomic,copy)HYStepperCallback valueChanged;

@end
