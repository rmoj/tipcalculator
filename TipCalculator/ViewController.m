//
//  ViewController.m
//  TipCalculator
//
//  Created by Rene Mojica on 2016-07-08.
//  Copyright © 2016 Rene Mojica. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;



@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self prepareTextFields];
    [self addKeyboardObserver];
    
    
}

- (void) prepareTextFields {
    self.billAmountTextField.delegate = self;
    self.tipPercentageTextField.delegate =  self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
//    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    float tip = [self.billAmountTextField.text floatValue] * [self.tipPercentageTextField.text floatValue]/100;

    self.tipAmountLabel.text = [NSString stringWithFormat:@"%.2f", tip];
    
}


//    
//#pragma mark - Setup TextField
//
//- (void)setupTextField {
//    self.textField.placeholder = @"Type your name";
//    self.textField.textColor = [UIColor redColor];
//    self.textField.delegate = self;
//    [self customizeKeyboard];
//}
//
//- (void)customizeKeyboard {
//    // the protocol UITextInputTraits determines what keyboard is shown
//    // You can customize the keyboard progrommatically or by setting it in IB
//    // tracing the hierarchy of protocols from which UITextField and UITextView inherit the keyboardType  property is instructive.
//    // both UITextField & UITextView conform to UITextInput protocol
//    // UITextInput protocol inherits from UIKeyInput protocol
//    // UIKeyInput protocol inherits from UITextInputTraits
//    // It is in UITextInputTraits that we find the keyboardType property!
//    self.textField.keyboardType = UIKeyboardTypeAlphabet;
//}

//#pragma mark - Handle Keyboard
//
- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"%@",notification.userInfo);
    CGFloat kbHeight = [self heightForNotification:notification];
    [self adjustViewForKeyboardHeight:kbHeight];
}

// Move max height of superview (self.view.bounds.height)

- (CGFloat)heightForNotification:(NSNotification *)notification {
    NSValue *keyboardInfo = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [keyboardInfo CGRectValue];
    return rect.size.height;
}

- (void)adjustViewForKeyboardHeight:(CGFloat)height {
    CGRect viewBounds = self.view.bounds;
    viewBounds.origin.y += height;
    NSLog(@"%@", NSStringFromCGRect(viewBounds));
    self.view.bounds = viewBounds;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    CGFloat kbHeight = [self heightForNotification:notification];
    [self adjustViewForKeyboardHeight:-kbHeight];
}

// we intercept touchesBegan on the ViewController's view property to dismiss the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.billAmountTextField isFirstResponder]) {
        [self.billAmountTextField resignFirstResponder];
    }
    if ([self.tipPercentageTextField isFirstResponder]) {
        [self.tipPercentageTextField resignFirstResponder];
    }

    
}

//// This is a delegate method that fires when the keyboard's return key is tapped
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
