//
//  TouchScrollView.m
//  SettingsBudle
//
//  Created by KentarOu on 2014/08/31.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "TouchScrollView.h"

@implementation TouchScrollView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
