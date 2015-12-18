//
//  ViewController.h
//  tutrial_demo_2
//
//  Created by Miki Takahashi on 2015/12/18.
//  Copyright © 2015年 Miki Takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutrialViewController : UIViewController<UIGestureRecognizerDelegate>{
    UIScrollView* scrollView;
    UIScrollView* bgScrollView;
    NSTimer* timer;
    int where;
    int count;
}

- (IBAction)handleOfLeft:(id)sender;
- (IBAction)handleOfRight:(id)sender;


@end

