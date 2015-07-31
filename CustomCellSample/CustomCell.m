//
//  CustomCell.m
//  CustomCellSample
//
//  Created by Daisuke Hirata on 2015/7/31
//  Copyright 2015 Daisuke Hirata. All rights reserved.
//

#import "CustomCell.h"

//====================================================================

@interface SlideView : UIView {
}
@end

@implementation SlideView

#define CUSTOMCELL_OBJECT_LENGTH 10.0
#define CUSTOMCELL_SHADOW_OFFSET 5.0
#define CUSTOMCELL_SHADOW_BLUR 5.0

- (void)drawRect:(CGRect)rect {
  // draw edge shadow
  // NSLog(@"-[SlideView drawRect:] %@", NSStringFromCGRect(rect));
  CGRect frame = self.bounds;
  frame.origin.x -= CUSTOMCELL_OBJECT_LENGTH;
  frame.origin.y -= CUSTOMCELL_OBJECT_LENGTH;
  frame.size.width += CUSTOMCELL_OBJECT_LENGTH;
  frame.size.height = CUSTOMCELL_OBJECT_LENGTH;

  CGContextRef context = UIGraphicsGetCurrentContext();

  // CGContextSetShadow(
  //    context, CGSizeMake(CUSTOMCELL_SHADOW_OFFSET, CUSTOMCELL_SHADOW_OFFSET),
  //    CUSTOMCELL_SHADOW_BLUR);

  [[UIColor whiteColor] setFill];
  CGContextFillRect(context, frame);
}

@end
;

//====================================================================

@interface BaseView : UIView {
}
@property(nonatomic, assign) BOOL selected;
@end

@implementation BaseView
@synthesize selected;

- (void)drawRect:(CGRect)rect {
  // draw
  // NSLog(@"-[BaseView drawRect:] %@", NSStringFromCGRect(rect));

  if (selected) {

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.9f, 0.9f, 0.9f, 0.9f, 0.7f, 0.7f, 0.7f, 0.7f};

    size_t count = sizeof(components) / (sizeof(CGFloat) * 4);

    CGContextAddRect(context, self.frame);

    CGRect frame = self.bounds;
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = frame.origin;
    endPoint.y = frame.origin.y + frame.size.height;

    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(
        colorSpaceRef, components, NULL, count);

    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint,
                                kCGGradientDrawsAfterEndLocation);

    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
  }
}
@end

//====================================================================
@implementation CustomCell
@synthesize baseView;
@synthesize slideView;

@synthesize nameLabel;
@synthesize imageView;

- (void)dealloc {
  self.baseView = nil;
  self.slideView = nil;

  self.nameLabel = nil;
  self.imageView = nil;
  [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  //   self selected
  //    0   0    => 0
  //    0   1    => 1
  //    1   0    => 0
  //    1   1    => 0
  BOOL realSelected = !self.selected && selected;
  [super setSelected:realSelected animated:animated];
  self.baseView.selected = realSelected;
  [self.baseView setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  UIColor *selectedColor = [UIColor whiteColor]; // default color
  if (highlighted) {
    selectedColor = [UIColor lightGrayColor];
  }
  self.baseView.backgroundColor = selectedColor;
  [super setHighlighted:highlighted animated:animated];
}

- (void)setSlideOpened:(BOOL)slideOpened animated:(BOOL)animated {
  if (slideOpened == slideOpened_) {
    return;
  }
  slideOpened_ = slideOpened;

  //    if (![self.subviews containsObject:self.slideView]) {
  //        [self insertSubview:self.slideView atIndex:0];
  //    }

  if (animated) {
    if (slideOpened_) {
      // open slide
      [UIView animateWithDuration:0.5
          delay:0
          usingSpringWithDamping:0.6
          initialSpringVelocity:0
          options:UIViewAnimationCurveEaseInOut
          animations:^{
            CGRect frame = self.baseView.frame;
            frame.origin.x -= frame.size.width / 2;
            self.baseView.frame = frame;
          }
          completion:^(BOOL finished) {
            nil;
          }];

    } else {
      // close slide
      [UIView animateWithDuration:0.15
                       animations:^{
                         CGRect frame = self.baseView.frame;
                         frame.origin.x = 8;
                         self.baseView.frame = frame;
                       }];
    }
  } else {
    CGRect frame = self.baseView.frame;
    if (slideOpened_) {
      // open slide
      frame.origin.x += frame.size.width;

    } else {
      // close slide
      frame.origin.x = 0;
    }
    self.baseView.frame = frame;
  }
}

@end
