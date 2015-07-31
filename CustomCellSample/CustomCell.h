//
//  CustomCell.h
//  CustomCellSample
//
//  Created by Daisuke Hirata on 2015/7/31
//  Copyright 2015 Daisuke Hirata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseView, SlideView;
@interface CustomCell : UITableViewCell {

  BOOL slideOpened_;
}
@property(nonatomic, retain) IBOutlet BaseView *baseView;
@property(nonatomic, retain) IBOutlet SlideView *slideView;

@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;

- (void)setSlideOpened:(BOOL)slideOpened animated:(BOOL)animated;

@end
