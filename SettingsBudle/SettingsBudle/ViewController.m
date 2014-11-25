//
//  ViewController.m
//  SettingsBudle
//
//  Created by KentarOu on 2014/08/28.
//  Copyright (c) 2014年 KentarOu. All rights reserved.
//

#import "ViewController.h"
#import "TouchScrollView.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *multiTitleArray;
    NSString *tmpString;
}
@property (weak, nonatomic) IBOutlet TouchScrollView *baseScrollView;

@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *build;

@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;

@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;

@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;

@property (weak, nonatomic) IBOutlet UIPickerView *multiPickerView;
@end

@implementation ViewController
            
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    multiTitleArray = @[@"Select 001",@"Select 002",@"Select 003",@"Select 004",@"Select 005"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_baseScrollView setContentSize:CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(_multiPickerView.frame))];
}
;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// Settings Bundleから値を取得
- (void)DidBecomeActive:(NSNotificationCenter*)notification
{
    _version.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    _build.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    _slider1.value = [[userDefaults stringForKey: @"sliderID001"] floatValue];
    _slider2.value = [[userDefaults stringForKey: @"sliderID002"] floatValue];
    
    _textfield1.text = [userDefaults stringForKey: @"textfieldID001"];
    _textfield2.text = [userDefaults stringForKey: @"textfieldID002"];
    
    _switch1.on = [[userDefaults stringForKey:@"switchID001"] boolValue];
    _switch2.on = [[userDefaults stringForKey:@"switchID002"] boolValue];
    
    tmpString = [userDefaults stringForKey:@"multiID0001"];
    if(tmpString) {
        NSUInteger index = [multiTitleArray indexOfObject:tmpString];
        [_multiPickerView selectRow:index inComponent:0 animated:NO];
    } else {
        [_multiPickerView selectRow:0 inComponent:0 animated:NO];
    }
    
}

// Settings Bundleに値をセット
- (void)DidEnterBackground:(NSNotificationCenter*)notification
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@(_slider1.value) forKey:@"sliderID001"];
    [userDefaults setObject:@(_slider2.value) forKey:@"sliderID002"];
    
    [userDefaults setObject:_textfield1.text forKey:@"textfieldID001"];
    [userDefaults setObject:_textfield2.text forKey:@"textfieldID002"];
    
    [userDefaults setObject:@(_switch1.on) forKey:@"switchID001"];
    [userDefaults setObject:@(_switch2.on) forKey:@"switchID002"];
    
    [userDefaults setObject:tmpString forKey:@"multiID0001"];
    
    [userDefaults synchronize];
}


/**
 * ピッカーに表示する列数を返す
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/**
 * ピッカーに表示する行数を返す
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

/**
 * ピッカーに表示する値を返す
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return multiTitleArray[row];
}

/**
 * ピッカーの選択行が決まったとき
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger value = [pickerView selectedRowInComponent:0];
    tmpString = multiTitleArray[value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
