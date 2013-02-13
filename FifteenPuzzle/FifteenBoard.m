//
//  FifteenPuzzle.m
//  FifteenPuzzle
//
//  Created by Justin Shelton on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FifteenBoard.h"
#import "ViewController.h"

@implementation FifteenBoard

-(id)init{
  for (int i = 0; i < 15; i++) {
    grid[i] = i+1;
  }
  grid[15] = 0;
  
  return self;
}

-(void)scramble:(int)n{
  for (int i = 0; i < n; i++) {
    int ran = rand()%4;
    int spaceRow;
    int spaceCol;
    
    [self getRow:&spaceRow Column:&spaceCol ForTile:0];
    
    if(ran == 0){
      if (spaceRow != 0) {
        [self slideTileAtRow:spaceRow-1 Column:spaceCol];
      }
    } else if(ran == 1){
      if (spaceRow != 3) {
        [self slideTileAtRow:spaceRow+1 Column:spaceCol];
      }
    } else if(ran == 2){
      if (spaceCol != 0) {
        [self slideTileAtRow:spaceRow Column:spaceCol-1];
      }
    } else if(ran == 3){
      if (spaceCol != 3) {
        [self slideTileAtRow:spaceRow Column:spaceCol+1];
      }
    }
  }  
}

-(int)getTileAtRow:(int)row Column:(int)col{
  return grid[row*4+col];
}

-(void)getRow:(int*)row Column:(int*)col ForTile:(int)tile{
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i*4+j] == tile) {
        *row = i; *col = j;
      }
    }
  }
}

-(BOOL)isSolved{
  for (int i = 0; i < 14; i++) {
    if(grid[i] != i+1){
      return FALSE;
    }
  }
  if(grid[15] != 0){
    return FALSE;
  } else {
    return TRUE;
  }
  // should never get here
  exit(EXIT_FAILURE); // infact, exit with an error if you do
}

-(BOOL)canSlideTileUpAtRow:(int)row Column:(int)col{
  if(row == 0) return FALSE;
  if([self getTileAtRow:row-1 Column:col] == 0){
    return TRUE;
  } else {
    return FALSE;
  }
}

-(BOOL)canSlideTileDownAtRow:(int)row Column:(int)col{
  if(row == 3) return FALSE;
  if([self getTileAtRow:row+1 Column:col] == 0){
    return TRUE;
  } else {
    return FALSE;
  }
}

-(BOOL)canSlideTileLeftAtRow:(int)row Column:(int)col{
  if(col == 0) return FALSE;
  if([self getTileAtRow:row Column:col-1] == 0){
    return TRUE;
  } else {
    return FALSE;
  }
}

-(BOOL)canSlideTileRightAtRow:(int)row Column:(int)col{
  if(col == 3) return FALSE;
  if([self getTileAtRow:row Column:col+1] == 0){
    return TRUE;
  } else {
    return FALSE;
  }
}

-(void)slideTileAtRow:(int)row Column:(int)col{
  if([self canSlideTileUpAtRow:row Column:col]){
    int hold = [self getTileAtRow:row Column:col];
    grid[row*4+col] = [self getTileAtRow:row-1 Column:col];
    grid[(row-1)*4+col] = hold;
  } else if([self canSlideTileDownAtRow:row Column:col]){
    int hold = [self getTileAtRow:row Column:col];
    grid[row*4+col] = [self getTileAtRow:row+1 Column:col];
    grid[(row+1)*4+col] = hold;
  } else if([self canSlideTileLeftAtRow:row Column:col]){
    int hold = [self getTileAtRow:row Column:col];
    grid[row*4+col] = [self getTileAtRow:row Column:col-1];
    grid[row*4+(col-1)] = hold;
  } else if([self canSlideTileRightAtRow:row Column:col]){
    int hold = [self getTileAtRow:row Column:col];
    grid[row*4+col] = [self getTileAtRow:row Column:col+1];
    grid[row*4+(col+1)] = hold;
  }
}

@end
