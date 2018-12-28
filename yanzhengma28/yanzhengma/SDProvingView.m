//
//  SDProvingView.m
//  yanzhengma
//
//  Created by xialan on 2018/12/27.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDProvingView.h"
#import "SDTextField.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//输入框的宽
#define KTFWidth 50
//输入框的高
#define KTFHeight 50
//输入框的个数
#define KTFCounts 4
//输入框之间的间距
#define KTFSpacing 14
//一个tag常量, 没有实际意义
#define KTagNumber 10
//输入框下面线的高度
#define KTFBottomLineHeight 3

@interface SDProvingView()<UITextFieldDelegate,SDTextFieldDelegate>

/** 保存输入框 */
@property (nonatomic, strong) NSMutableArray *arrayM;

@end

@implementation SDProvingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, (KTFWidth+KTFSpacing)*KTFCounts, KTFHeight+KTFBottomLineHeight+1);

        _arrayM = [NSMutableArray array];
        
        for (NSInteger i = 0; i < KTFCounts; i++) {
            
            SDTextField *tf = [self textFieldWithTag:i];
            tf.delegate = self;
            tf.sd_delegate = self;
            tf.tag = KTagNumber+i;
            [tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            UIView *line = [self underLineViewWithTextfield:tf];
            line.tag =tf.tag + KTagNumber;
            [self addSubview:tf];
            [self addSubview:line];
            
            
            
            
        }
        
        
        
    }
    return self;
}



-(UIView *)underLineViewWithTextfield:(UITextField *)topTF{
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGBA(242, 242, 242, 1);
    line.frame = CGRectMake(topTF.frame.origin.x, CGRectGetMaxY(topTF.frame), topTF.frame.size.width, 3);
    line.layer.cornerRadius = 3*0.5;
    line.layer.masksToBounds = YES;
    
    return line;
    
}

-(SDTextField *)textFieldWithTag:(NSInteger)tag{
    
    SDTextField *tf = [[SDTextField alloc] init];
    tf.frame = CGRectMake(tag*(KTFWidth+KTFSpacing), 0, KTFWidth, KTFHeight);
    tf.textColor = RGBA(34, 34, 34, 1);
    tf.font = [UIFont systemFontOfSize:28];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.textAlignment = NSTextAlignmentCenter;
    
    return tf;
}

#pragma mark - get方法 获取输入结果
-(NSString *)resultString{
    
    NSString *string = @"";
    for (NSInteger i = 0; i < self.arrayM.count; i++) {
        SDTextField *textField = self.arrayM[i];
        string = [string stringByAppendingFormat:@"%@",textField.text];
    }
    
    _resultString = string;
    
    return _resultString;
}


#pragma mark - 监听删除
-(void)textFieldDeleteBackward:(SDTextField *)textField{
    
    
    //删除相同的tag的输入框
    [self deleteSameTagInArrayWithTag:textField.tag];


     NSLog(@"删除:-- %zd",self.arrayM.count);
    
    if (textField.text == nil || [textField.text isEqualToString:@""]) {
        UIView *line = [self viewWithTag:textField.tag + KTagNumber];
        line.backgroundColor = RGBA(242, 242, 242, 1);
        if (textField.tag-1 < KTagNumber) return; //到达第一个就停止
        SDTextField *tf = [self viewWithTag:textField.tag-1];
        [tf becomeFirstResponder];
        
        
    }
    
    
   
    
}



#pragma mark - 监听输入
-(void)textFieldDidChange:(UITextField *)textField{
    
    BOOL isNumber = [self validateNumber:textField.text];
    if (!isNumber) {
        
        textField.text = @"";
        
        return;
    }else{
        if (textField.text.length >= 1) {
            
            //先删除相同的tag的输入框
            [self deleteSameTagInArrayWithTag:textField.tag];
    
            if (self.arrayM.count>=textField.tag - KTagNumber) {
                [_arrayM insertObject:textField atIndex:textField.tag - KTagNumber];
            }
            
            
             NSLog(@"---cout---:%zd",self.arrayM.count);
            

            //只保留一位数字
            textField.text = [textField.text substringToIndex:1];
            //下一个输入框成为第一响应者
            SDTextField *tf = [self viewWithTag:textField.tag+1];
            [tf becomeFirstResponder];
            
            //改变线的颜色
            UIView *line = [self viewWithTag:textField.tag+KTagNumber];
            line.backgroundColor = RGBA(254, 90, 100, 1);
            
            //到达最后一个就停止
            if(textField.tag+1 > (KTagNumber+KTFCounts-1)) return;
        }
        
    }
    
    
    
    
    
}

#pragma mark - 内部调用 - 删除数组中相同tag的SDTextField
-(void)deleteSameTagInArrayWithTag:(NSInteger)tag{
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.arrayM];
    
    [tempArray enumerateObjectsUsingBlock:^(SDTextField *obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.tag == tag) {
            
            *stop = YES;
            
            if (*stop == YES) {
                
                [self.arrayM removeObject:obj];
                
            }
            
        }
        
    }];

}


#pragma mark - 内部调用 - 判断输入的是否为数字
- (BOOL)validateNumber:(NSString*)number {
    
    
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;

    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
