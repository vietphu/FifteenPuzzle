//
//  ViewController.m
//  FifteenPuzzle
//
//  Created by Guest User on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "FifteenBoard.h"
#define NUM_SHUFFLES 300

@implementation ViewController
@synthesize boardView;
@synthesize board;
@synthesize label;

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.board = [[FifteenBoard alloc] init];
  
  UIImage* image = [UIImage imageNamed:@"bg.png"];
  [self setBackgroundImageOfButtons:image];
  [self scrambleTiles:self];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [boardView becomeFirstResponder]; //shake gesture requires this
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
  [boardView resignFirstResponder]; //also shake
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

-(IBAction)tileSelected:(UIButton *)sender {
  const int tag = [sender tag];
  int row, col;
  [board getRow:&row Column:&col ForTile:tag];
  CGRect buttonFrame = sender.frame;
  if ([board canSlideTileUpAtRow:row Column:col]) {
    [board slideTileAtRow:row Column:col];
    buttonFrame.origin.y = (row-1)*buttonFrame.size.height;
    [UIView animateWithDuration:0.5 animations:^{sender.frame = buttonFrame;}];
  } else if ([board canSlideTileDownAtRow:row Column:col]) {
    [board slideTileAtRow:row Column:col];
    buttonFrame.origin.y = (row+1)*buttonFrame.size.height;
    [UIView animateWithDuration:0.5 animations:^{sender.frame = buttonFrame;}];
  } else if ([board canSlideTileLeftAtRow:row Column:col]) {
    [board slideTileAtRow:row Column:col];
    buttonFrame.origin.x = (col-1)*buttonFrame.size.width;
    [UIView animateWithDuration:0.5 animations:^{sender.frame = buttonFrame;}];    
  } else if ([board canSlideTileRightAtRow:row Column:col]) {
    [board slideTileAtRow:row Column:col];
    buttonFrame.origin.x = (col+1)*buttonFrame.size.width;
    [UIView animateWithDuration:0.5 animations:^{sender.frame = buttonFrame;}];    
  }
  
  //set status message
  if ([board isSolved]) {
    [label setText:@"You Win!"];
  } else {
    [label setText:@""];
  }
}

-(IBAction)scrambleTiles:(id)sender {
  [board scramble:NUM_SHUFFLES];
  while ([board isSolved]) {
    [board scramble:NUM_SHUFFLES]; //potential for trouble but unlikely
  }
  [self arrangeBoardView];
}

-(void)arrangeBoardView {
  const CGRect boardBounds = boardView.bounds;
  const CGFloat tileWidth = boardBounds.size.width / 4;
  const CGFloat tileHeight = boardBounds.size.height / 4;
  for (int row = 0; row < 4; row++) {
    for (int col = 0; col < 4; col++) {
      const int tile = [board getTileAtRow:row Column:col];
      if (tile > 0) {
        __weak UIButton *button = (UIButton *)[boardView viewWithTag:tile];
        //apply the image blocks to the buttons
        [button setBackgroundImage:[array objectAtIndex:tile-1] forState:UIControlStateNormal];
        button.frame = CGRectMake(col*tileWidth, row*tileHeight, tileWidth, tileHeight);
      }
    }
  }
}

//cut the background image
-(void)setBackgroundImageOfButtons:(UIImage *)image {
  CGImageRef tempImage;
  CGRect tempRect;
  CGFloat x, y;
  UIImage *image2;
  
  array = [NSMutableArray new];
  
  for (int row = 0; row < 4; row++) {
    y = row * 75;
    for (int col = 0; col < 4; col++) {
      x = col * 75;
      
      tempRect = CGRectMake(x, y, 75, 75);
      
      tempImage = CGImageCreateWithImageInRect(image.CGImage, tempRect);
      
      image2 = [UIImage imageWithCGImage:tempImage];
      [array addObject:image2];
      
      image2 = nil;
      CGImageRelease(tempImage);
    }
  }
}

//handle a shake
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
  if ( event.subtype == UIEventSubtypeMotionShake ){
    [self scrambleTiles:self];
  }
  
  if ([super respondsToSelector:@selector(motionEnded:withEvent:)])
    [super motionEnded:motion withEvent:event];
}

-(BOOL)canBecomeFirstResponder{
  return YES;
}

@end
