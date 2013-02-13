//
//  ViewController.h
//  FifteenPuzzle
//
//  Created by Guest User on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FifteenBoard;
@interface ViewController : UIViewController {
  @private
  NSMutableArray *array;
}
@property(weak,nonatomic) IBOutlet UIView *boardView;
@property(strong,nonatomic) FifteenBoard *board;
@property(weak,nonatomic) IBOutlet UILabel *label;

-(IBAction)tileSelected:(UIButton*)sender;
-(IBAction)scrambleTiles:(id)sender;
-(void)arrangeBoardView;
-(void)setBackgroundImageOfButtons:(UIImage*)image;

@end
