//
//  ViewController.m
//  yanzhengma
//
//  Created by xialan on 2018/12/27.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "ViewController.h"
#import "SDProvingView.h"

@interface ViewController ()

@property (nonatomic, strong)SDProvingView *inputView;


@property (nonatomic, strong) UILabel *resultShowLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _inputView = [[SDProvingView alloc] initWithFrame:CGRectMake(50, 300, 300, 100)];
    
    [self.view addSubview:_inputView];
    
    _resultShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 100, 40)];
    _resultShowLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_resultShowLabel];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@",_inputView.resultString);
    _resultShowLabel.text = [NSString stringWithFormat:@"结果:%@",_inputView.resultString];
}

@end
