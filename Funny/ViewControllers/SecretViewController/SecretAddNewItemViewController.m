//
//  SecretAddNewItemViewController.m
//  Funny
//
//  Created by yanzhen on 15/10/28.
//  Copyright (c) 2015年 yanzhen. All rights reserved.
//

#import "SecretAddNewItemViewController.h"
#import "SecretPasswordViewController.h"
#import "YZTextField.h"
#import "MBProgressHUD+YZZ.h"
#import "SecretTitleView.h"
#import "YZKeyboardTool.h"

@interface SecretAddNewItemViewController ()<SecretDidSelectDelegate,KeyBoardActionDelegate>
@property (weak, nonatomic) IBOutlet YZTextField *companyTextField;
@property (weak, nonatomic) IBOutlet YZTextField *rowTextField;
@property (weak, nonatomic) IBOutlet YZTextField *accountTextField;
@property (weak, nonatomic) IBOutlet YZTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet YZTextField *remarksTextField;
@property (nonatomic, assign) BOOL isModify;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, copy) NSString *titles;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *rowButton;
@property (nonatomic, strong) SecretTitleView *titleView;
@property (nonatomic, strong) SecretModel *model;
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, assign) SecretPasswordViewController *pvc;
@property (nonatomic, strong) NSMutableArray *textFields;
@property (nonatomic, assign) CGRect keyBoardFrame;
@end

@implementation SecretAddNewItemViewController
//添加
- (instancetype)initWithTitleArray:(NSArray *)titleArray viewController:(id)vc
{
    if (self = [super init]) {
        self.titleArray=titleArray;
        self.pvc=vc;
        [self.rightButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    return self;
}
//修改
-(instancetype)initWithSecretModel:(SecretModel *)model titleArray:(NSString *)title viewController:(id)vc indexPath:(NSIndexPath *)indexPath
{
    if (self = [super init]) {
        self.isModify=YES;
        self.titles=title;
        self.pvc=vc;
        self.indexPath=indexPath;
        [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
        _model=model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_isModify) {
        _rowTextField.text=self.titles;
        _companyTextField.text=_model.company;
        _accountTextField.text=_model.account;
        _passwordTextField.text=_model.password;
        _remarksTextField.text=_model.remarks;
    }
    self.rowButton.frame=CGRectMake(self.rowTextField.frame.origin.x, self.rowTextField.frame.origin.y, WIDTH-60, 40);
    [self.view addSubview:self.rowButton];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
    [self confUI];
    [self addObserve];
}
- (void)confUI
{
    //创建工具栏
    YZKeyboardTool *tool = [YZKeyboardTool keyboardToolStandard];
    //设置代理
    tool.delegate = self;
    for (UITextField *textField in self.textFields) {
        //如果子控制是UITextField的时候，设置inputAccessoryView
            textField.inputAccessoryView = tool;
            //把textfield添加到数组
    }
}
#pragma mark - action
- (void)saveButtonAction
{
    if ([self oneTextFieldIsNil]) {
        return;
    }
    if (_isModify) {
        SecretModel *model=[[SecretModel alloc] init];
        model.company=_companyTextField.text;
        model.account=_accountTextField.text;
        model.password=_passwordTextField.text;
        model.remarks=_remarksTextField.text;
        [self.pvc modifyPassword:model indexPath:self.indexPath];
    }else{
        SecretModel *model=[[SecretModel alloc] init];
        model.company=_companyTextField.text;
        model.account=_accountTextField.text;
        model.password=_passwordTextField.text;
        model.remarks=_remarksTextField.text;
        [self.pvc addNewPassword:model row:self.indexPath.row];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)oneTextFieldIsNil
{
    if (self.rowTextField.text.length<=0) {
        [MBProgressHUD showError:@"请选择分组"];
        return YES;
    }else if (self.accountTextField.text.length<=0){
        [MBProgressHUD showError:@"请输入账号"];
        return YES;
    }else if (self.passwordTextField.text.length<=0){
        [MBProgressHUD showError:@"请输入密码"];
        return YES;
    }else{
        return NO;
    }
}
- (void)tapAction
{
    for (UITextField *textField in self.textFields) {
        if (textField.isFirstResponder) {
            [textField resignFirstResponder];
        }
    }
}
- (void)rowButtonAction
{
    if (_isModify) {
        return;
    }
    [self.titleView toggleSecretTitleView];
}
- (void)pre{
    NSInteger preIndex = [self getCurrentResponderIndex]-1;
    if (preIndex >=1 ) {
        UITextField *textField=[self.textFields objectAtIndex:preIndex];
        [textField becomeFirstResponder];
        [self changeFrame];
    }
}
- (void)next{
    NSInteger nextIndex = [self getCurrentResponderIndex]+1;
    if (nextIndex < self.textFields.count) {
        UITextField *textField=[self.textFields objectAtIndex:nextIndex];
        [textField becomeFirstResponder];
        [self changeFrame];
    }

}
- (void)done{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark -  delegate
- (void)didSelectAtIndexPath:(NSString *)title indexPath:(NSIndexPath *)indexPath
{
    self.rowTextField.text=title;
    self.indexPath=indexPath;
}
-(void)keyBoardClick:(NSInteger)index
{
    if (index == yPre) {
        [self pre];
    }else if (index == yNext){
        [self next];
    }else if (index == yDone){
        [self done];
    }
}
#pragma mark - lazy loading
- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [_rightButton setFrame:CGRectMake(0, 0, 40, 40)];
        [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
-(UIButton *)rowButton
{
    if (!_rowButton) {
        _rowButton=[UIButton buttonWithType:UIButtonTypeSystem];
        _rowButton.backgroundColor=[UIColor clearColor];
        [_rowButton addTarget:self action:@selector(rowButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _rowButton.layer.masksToBounds=YES;
        _rowButton.layer.cornerRadius=6;
    }
    return _rowButton;
}
-(SecretTitleView *)titleView
{
    if (!_titleView) {
        _titleView=[[SecretTitleView alloc] initWithFrame:CGRectMake(self.rowTextField.frame.origin.x, CGRectGetMaxY(self.rowTextField.frame), WIDTH-60, 0) titleArray:self.titleArray];
        _titleView.delegate=self;
        [self.view addSubview:_titleView];
    }
    return _titleView;
}
- (NSMutableArray *)textFields
{
    if (!_textFields) {
        _textFields=[[NSMutableArray alloc] init];
        [_textFields addObject:_rowTextField];
        [_textFields addObject:_companyTextField];
        [_textFields addObject:_accountTextField];
        [_textFields addObject:_passwordTextField];
        [_textFields addObject:_remarksTextField];
    }
    return  _textFields;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self tapAction];
    if (!self.titleView.isSecretTitleViewHidden) {
        [self.titleView toggleSecretTitleView];
    }
}
- (void)addObserve{
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - notify
- (void)keyboardFrameChange:(NSNotification *)notifi
{
    self.keyBoardFrame =[notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //键盘结束时的y
    [self changeFrame];
}
-(NSInteger)getCurrentResponderIndex{
    //遍历所有的textfield获取响应者
    for (UITextField *tf in self.textFields) {
        if (tf.isFirstResponder) {
            return [self.textFields indexOfObject:tf];
        }
    }
    
    return -1;
}
- (void)changeFrame
{
    CGRect frame =self.keyBoardFrame;
    
    //键盘结束时的y
    CGFloat kbEndY = frame.origin.y;
    
    
    //获取当前的响应者
    NSInteger currentIndex = [self getCurrentResponderIndex];
    UITextField *currentTf = self.textFields[currentIndex];
    CGFloat tfMaxY = CGRectGetMaxY(currentTf.frame);
    
    //如果textfield的最大值在于键盘的y坐，才要往上移
    if (tfMaxY > kbEndY) {
        [UIView animateWithDuration:0.15 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, kbEndY - tfMaxY);
        }];
    }else{
        [UIView animateWithDuration:0.15 animations:^{
            //恢复到原来的位置
            self.view.transform = CGAffineTransformIdentity;
        }];
    }

}
@end
