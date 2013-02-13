//
//  FifteenPuzzle.h
//  FifteenPuzzle
//
//  Created by Justin Shelton on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ViewController;
@interface FifteenBoard : NSObject {
  @private
  int grid[16];
}

-(id)init;
-(void)scramble:(int)n;
-(int)getTileAtRow:(int)row Column:(int)col;
-(void)getRow:(int*)row Column:(int*)col ForTile:(int)tile;
-(BOOL)isSolved;
-(BOOL)canSlideTileUpAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileDownAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileLeftAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileRightAtRow:(int)row Column:(int)col;
-(void)slideTileAtRow:(int)row Column:(int)col;

@end
