//
//  DescriptionViewController.h
//  MapKitPractice
//
//  Created by Syngmaster on 13/05/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@protocol PopoverDismissDelegate;

@interface DescriptionViewController : UIViewController

@property (weak, nonatomic) id <PopoverDismissDelegate> delegate;
@property (strong, nonatomic) Person *person;

@end

@protocol PopoverDismissDelegate <NSObject>

- (void)dismissPopoverController:(DescriptionViewController *) viewController;

@end
