//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Gareth Jeanne on 01/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack;
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

-(void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

-(double)performOperation:(NSString *)operation{
    
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"*"]) {
        double multuplier = [self popOperand];
        result = [self popOperand] * multuplier;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"π"]){
        result = M_PI;
    } else if ([operation isEqualToString:@"+/-"]){
        double numberToSwitch = [self popOperand];
        if (!(numberToSwitch == 0)){
            result = (numberToSwitch * -1);
        }
        else {
            result = 0;
        }
        
    }

    
    [self pushOperand:result];
    
    return result;
    
}

-(void)clearAll{
    [self.operandStack removeAllObjects];
}

@end
