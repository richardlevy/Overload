//
//  Overload.h
//  Overload
//
//  Created by Richard Levy on 06/11/2012.
//  Copyright (c) 2012 Richard Levy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

static const int BOARD_SIZE=10;

@interface Overload : NSObject {
    @private
    Board* board;
    Colours player;
}

-(void)playGame;

@property int turnCounter;

@end
