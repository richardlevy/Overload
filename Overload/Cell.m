//
//  Cell.m
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import "Cell.h"


@implementation Cell

// Generate the getters and setters
@synthesize pieceCount;

// Initialise a new cell object
-(id) initWithLimit:(int)overloadLimit {

    self = [super init];
    
    if (self!=nil){
        self->colour = none;
    
        // Initialise count to 0
        self.pieceCount=0;
        
        self->limit=overloadLimit;
    }
    
    return self;
}

// Returns true is the cell is empty;
-(BOOL) isEmpty {
    return self->colour== none;
}

-(BOOL)isColour:(Colours)checkColour {
    return self->colour==checkColour;
}

-(BOOL)isOverloaded {
    return self->pieceCount >= self->limit;
}


// Adds a piece to this cell and sets the colour of the cell
-(void)addPieceOfColour:(Colours)newColour{
    // todo - check it's either empty or the colour being added
    self->colour=newColour;
    
    self.pieceCount++;
}

// Resets the colour to none and piece count to 0 - not the limit though
-(void)reset {
    self->colour=none;
    self->pieceCount=0;
}

// Returns a . for empty 123 for white, 789 for black
-(NSString*)description {
    int extra=self->colour==black?6:0;
    return [self isEmpty]?@".":[NSString stringWithFormat:@"%d",self->pieceCount+extra];
}

@end
