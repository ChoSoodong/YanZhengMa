//
//  SDTextField.h
//  yanzhengma
//
//  Created by ZHAO on 2018/12/27.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDTextField;

@protocol SDTextFieldDelegate<NSObject>

- (void)textFieldDeleteBackward:(SDTextField *)textField;

@end

@interface SDTextField : UITextField

@property (nonatomic, assign) id <SDTextFieldDelegate> sd_delegate;

@end

