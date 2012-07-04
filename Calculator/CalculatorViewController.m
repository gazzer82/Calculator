//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Gareth Jeanne on 01/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userHasAlreadyEnteredFloatingPoint;
@property (nonatomic) BOOL stackHasBeenCreated;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) NSString* lastEnteredNumber;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userHasAlreadyEnteredFloatingPoint;
@synthesize operandStackDisplay;
@synthesize stackHasBeenCreated;
@synthesize brain = _brain;
@synthesize lastEnteredNumber;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    if (([digit isEqualToString:@"."]) && (self.userHasAlreadyEnteredFloatingPoint == NO) && (self.userIsInTheMiddleOfEnteringANumber == YES)){
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.userHasAlreadyEnteredFloatingPoint = YES;
    }
    
    else if ( (![digit isEqualToString:@"."])&& (self.userIsInTheMiddleOfEnteringANumber)) {
            self.display.text = [self.display.text stringByAppendingString:digit];
    } 
    
    else if (([digit isEqualToString:@"."]) && (self.userHasAlreadyEnteredFloatingPoint == YES) && (self.userIsInTheMiddleOfEnteringANumber == YES)){
    }
    else {    
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed {
    self.operandStackDisplay.text = [self.operandStackDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@",self.display.text]];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasAlreadyEnteredFloatingPoint = NO;
    self.stackHasBeenCreated = YES;
}
- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.operandStackDisplay.text = [self.operandStackDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@ =",operation]];
}


- (IBAction)clearButton:(id)sender {;
    self.operandStackDisplay.text = [NSString stringWithFormat:@" "];
    self.display.text = [NSString stringWithFormat:@"0"];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasAlreadyEnteredFloatingPoint = NO;
    [self.brain clearAll];
}
- (IBAction)backspacePressed {
    if ( [self.display.text length] > 1){
            self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    }else{
            self.display.text = [NSString stringWithFormat:@"0"];
            self.userIsInTheMiddleOfEnteringANumber = NO;
            self.userHasAlreadyEnteredFloatingPoint = NO;
    }
}


- (void)viewDidUnload {
    [self setOperandStackDisplay:nil];
    [super viewDidUnload];
}
@end
