//
//  ViewController.m
//  MapKitPractice
//
//  Created by Syngmaster on 12/05/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "ViewController.h"
#import "AnnotationView.h"
#import "Person.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotationView.h>
#import "DescriptionViewController.h"
#import "UIView+AnnotationView.h"


@interface ViewController () <MKMapViewDelegate, UIPopoverPresentationControllerDelegate, PopoverDismissDelegate>

@property (strong, nonatomic) NSMutableArray *arrayOfAnnotations;

@property (strong, nonatomic) UIPopoverPresentationController *popVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayOfAnnotations = [NSMutableArray array];
    
    UIBarButtonItem* addButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self action:@selector(actionAdd:)];
    
    UIBarButtonItem* deleteButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                  target:self action:@selector(actionDelete:)];
    
    UIBarButtonItem* zoomButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                  target:self action:@selector(actionShowAll:)];

    self.navigationItem.rightBarButtonItems = @[addButton, deleteButton];
    self.navigationItem.leftBarButtonItem = zoomButton;

}


#pragma mark - Actions

- (void)actionAdd:(UIBarButtonItem *) sender {
    
    for (int i = 0; i < 15; i++) {
        
        Person *person = [Person generateRandomPerson];
        [self.mapView addAnnotation:person];
        [self.arrayOfAnnotations addObject:person];
    }
    
}

- (void)actionShowAll:(UIBarButtonItem *) sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(coordinate);
        
        static double delta = 10000;
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, 2 * delta, 2 * delta);
        
        zoomRect = MKMapRectUnion(rect, zoomRect);
    }
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(10, 10, 10, 10)
                           animated:YES];
    
}

- (void)actionDelete:(UIBarButtonItem *) sender {
    
    [self.mapView removeAnnotations:self.arrayOfAnnotations];
    [self.arrayOfAnnotations removeAllObjects];
}


- (void)descriptionAction:(UIButton *) sender {
    
    Person *person = (Person <MKAnnotation> *)[[sender superAnnotationView] annotation];
    
    DescriptionViewController *vc = [[DescriptionViewController alloc] init];
    vc.person = person;
    vc.delegate = self;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    navVC.modalPresentationStyle = UIModalPresentationPopover;
    navVC.preferredContentSize = CGSizeMake(300, 350);
    
    UIPopoverPresentationController *popVC = [navVC popoverPresentationController];
    popVC.sourceRect = sender.frame;
    popVC.sourceView = sender;
    popVC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popVC.delegate = self;
    self.popVC = popVC;

    [self presentViewController:navVC animated:YES completion:nil];
    
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(Person <MKAnnotation>*)annotation {
        
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
         
    static NSString *identifier = @"PinView";
    
    MKAnnotationView *pin = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];

        pin.canShowCallout = YES;
        pin.draggable = YES;
        pin.image = (annotation.gender == 0) ? [UIImage imageNamed:@"male.png"] : [UIImage imageNamed:@"female.png"];
        
        UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [descriptionButton addTarget:self action:@selector(descriptionAction:) forControlEvents:UIControlEventTouchUpInside];
        pin.rightCalloutAccessoryView = descriptionButton;

        
    } else {
        
        pin.annotation = annotation;

    }
    
    return pin;

}


#pragma mark - PopoverDismissDelegate

- (void)dismissPopoverController:(DescriptionViewController *)viewController {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        self.popVC = nil;
    }
    
}



@end
