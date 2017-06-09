//
//  HTNotesViewController.m
//  XuanYuan
//
//  Created by King on 2017/5/11.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTNotesViewController.h"

@interface HTNotesViewController ()<YYTextViewDelegate,UITextFieldDelegate>
@property (nonatomic,weak)YYTextView *textView;
@property (nonatomic,weak)UIToolbar *toolbar;
@property (nonatomic,weak)UITextField *textField;



@property (nonatomic,strong) UIBarButtonItem *finishBarbutton;
@property (nonatomic,strong) UIBarButtonItem *saveBarbutton;



@end

@implementation HTNotesViewController


-(UIBarButtonItem *)finishBarbutton
{
    if (_finishBarbutton == nil) {
        _finishBarbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textViewFinish)];
    }
    return _finishBarbutton;
}

-(UIBarButtonItem *)saveBarbutton
{
    if (_saveBarbutton == nil) {
        _saveBarbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNote)];
    }
    return _saveBarbutton;
}

-(HTMainItemModel *)model
{
    if (_model == nil) {
        _model = [[HTMainItemModel alloc]init];
    }
    return _model;
}

-(void)textViewFinish
{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
}
//保存笔记
-(void)saveNote
{
    if ([HTTools ht_isBlankString:self.model.accountTitle]||self.model.accountTitle.length<1) {
        NSArray *arr = [HTMainItemModel getNotesModelArray];
        if (arr.count>0) {
            self.model.accountTitle = [NSString stringWithFormat:@"%@(%lu)",@"新建备忘录",(unsigned long)arr.count];
        }else
        {
            self.model.accountTitle = [NSString stringWithFormat:@"%@",@"新建备忘录"];
        }
    }
    
    [self.model saveNotes];
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadClassification_Noti object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//文本中添加一张图片
-(void)addImage
{
    
}

-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"备忘录";
    
    
    [self setUI];
    
    [self layoutUI];
    
}

-(void)setRightBarbutton
{
    
    if ([self.textView isFirstResponder]) {
        
        self.navigationItem.rightBarButtonItem = self.finishBarbutton;
        
    }else
    {
        self.navigationItem.rightBarButtonItem = self.saveBarbutton;

        self.saveBarbutton.enabled = (self.textView.text.length>0);

    }
    
}


-(void)layoutUI
{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view).mas_offset(64);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.height.mas_equalTo(55);
        
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.textField.mas_bottom).mas_offset(0);
        make.left.equalTo(self.view).mas_offset(8);
        make.right.equalTo(self.view).mas_offset(-8);
        make.bottom.equalTo(self.view).mas_offset(-35);
        
    }];
    
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(35);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}



-(void)setUI
{
    
    
    UITextField *textField = [[UITextField alloc]init];
    self.textField = textField;
    self.textField.placeholder = @"请输入标题";
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:textField];
    

    YYTextView *textView = [[YYTextView alloc]init];
    [self.view addSubview:textView];
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 50, 10);
    textView.contentInset = UIEdgeInsetsMake( 0, 0, 100, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    textView.font = [UIFont boldSystemFontOfSize:15];
    textView.tintColor = MainRGB;
    textView.placeholderFont = [UIFont systemFontOfSize:15];
    textView.placeholderTextColor = MainTextColor;
    [textView becomeFirstResponder];
    
    textView.delegate = self;
    self.textView = textView;
    
    if (![HTTools ht_isBlankString:self.model.accountTitle]) {
        self.textField.text = self.model.accountTitle;
    }
    
    if (![HTTools ht_isBlankString:self.model.remarks]) {
        textView.text = self.model.remarks;
    }
    

    //暂时不需要这个
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    toolbar.tintColor = MainRGB;
    toolbar.barTintColor = MainTextWhiteColor;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)textViewDidBeginEditing:(YYTextView *)textView
{
    [self setRightBarbutton];
}

-(void)textViewDidChange:(YYTextView *)textView
{
    self.model.account = @"备忘录";
    self.model.passWord = @"";
    self.model.iconType = 1000;
    self.model.remarks = textView.text;
}


-(void)textViewDidEndEditing:(YYTextView *)textView
{
    [self setRightBarbutton];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.accountTitle = self.textField.text;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
