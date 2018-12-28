//
//  SDTextField.m
//  yanzhengma
//
//  Created by ZHAO on 2018/12/27.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDTextField.h"

@implementation SDTextField

- (void)deleteBackward {
    
       // ！！！这里要调用super方法，要不然删不了东西
        [super deleteBackward];
    
        if ([self.sd_delegate respondsToSelector:@selector(textFieldDeleteBackward:)]) {
        
                [self.sd_delegate textFieldDeleteBackward:self];
        
         }
    
}


@end
