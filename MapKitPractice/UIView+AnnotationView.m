//
//  UIView+AnnotationView.m
//  MapKitPractice
//
//  Created by Syngmaster on 13/05/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "UIView+AnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (AnnotationView)

- (MKAnnotationView*) superAnnotationView {
    
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
    
}

@end
