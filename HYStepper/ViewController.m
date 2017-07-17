//
//  ViewController.m
//  HYStepper
//
//  Created by zhuxuhong on 2017/7/16.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import "ViewController.h"
#import "HYStepper.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet HYStepper *stepper;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _stepper.valueChanged = ^(double value) {
        _label.text = [NSString stringWithFormat:@"%.f",value];
    };
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIApplication.sharedApplication.keyWindow endEditing:true];
}


@end
