//
//  RootViewController.h
//  CustomCellSample
//
//  Created by Daisuke Hirata on 2015/7/31
//  Copyright 2015 Daisuke Hirata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCell;
@class FooterView;
@interface RootViewController : UITableViewController {

  CGFloat cellHeight_;

  NSIndexPath *openedIndexPath_;
}
@property(nonatomic, retain) IBOutlet FooterView *footerView;
@property(nonatomic, retain) NSIndexPath *openedIndexPath;

// cell events
- (IBAction)didTouchDoitButton:(id)sender event:(UIEvent *)event;

- (IBAction)didTouchDeleteButton:(id)sender event:(UIEvent *)event;
- (IBAction)didTouchPostButton:(id)sender event:(UIEvent *)event;

@end
