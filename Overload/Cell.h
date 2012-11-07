//
//  Cell.h
//  Overload
//
//  Created by Richard Levy on 05/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {none, white, black} Colours;

@interface Cell : NSObject {

    int pieceCount;
    
    @private
    Colours colour;
    int limit;
    
}

// Declare pieceCount as a property so we don't have to declare getters and setters
// TODO - think this can be removed - only here for a test at the moment
@property int pieceCount;

- (id) initWithLimit:(int)overloadLimit;
- (BOOL)isEmpty;
- (BOOL)isColour:(Colours)checkColour;
- (BOOL)isOverloaded;
- (void)addPieceOfColour:(Colours)newColour;
- (void)reset;

@end
