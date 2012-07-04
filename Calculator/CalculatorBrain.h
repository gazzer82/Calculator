//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Gareth Jeanne on 01/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)clearAll;
-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
@end
