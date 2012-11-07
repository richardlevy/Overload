//
//  CoOrdinate.m
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import "CoOrdinate.h"

@implementation CoOrdinate

@synthesize x;
@synthesize y;

// Init with a value
-(id)initWithX:(int)newX Y:(int)newY {
    self=[super init];
    if (self!=nil){
        self.x = newX;
        self.y = newY;
    }
    
    return self;
}

-(CoOrdinate*)above {
    CoOrdinate* move = [[CoOrdinate alloc]init];
    move.x=self.x;
    move.y=self.y-1;
    return move;
}

-(CoOrdinate*)below {
    CoOrdinate* move = [[CoOrdinate alloc]init];
    move.x=self.x;
    move.y=self.y+1;
    return move;
}

-(CoOrdinate*)left {
    CoOrdinate* move = [[CoOrdinate alloc]init];
    move.x=self.x-1;
    move.y=self.y;
    return move;
}

-(CoOrdinate*)right {
    CoOrdinate* move = [[CoOrdinate alloc]init];
    move.x=self.x+1;
    move.y=self.y;
    return move;
}

@end
