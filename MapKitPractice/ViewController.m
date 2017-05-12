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


@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) NSMutableArray *arrayOfAnnotations;

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
    
    
}

- (void)actionDelete:(UIBarButtonItem *) sender {
    
    [self.mapView removeAnnotations:self.arrayOfAnnotations];
    [self.arrayOfAnnotations removeAllObjects];
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(Person <MKAnnotation>*)annotation {
    
    NSLog(@"description - %@", [annotation description]);
    
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

        
    } else {
        
        pin.annotation = annotation;

    }
    
    return pin;

}


@end
