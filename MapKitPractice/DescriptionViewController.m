//
//  DescriptionViewController.m
//  MapKitPractice
//
//  Created by Syngmaster on 13/05/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "DescriptionViewController.h"
#import "Person.h"

@interface DescriptionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (strong, nonatomic) NSString *address;

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.geoCoder = [[CLGeocoder alloc] init];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancelAction:)];
    
    self.navigationItem.rightBarButtonItem = cancelButton;
    [self getAddressFromCoordinates:self.person.coordinate];
    
}


- (void) dealloc {
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }

}

- (void)getAddressFromCoordinates:(CLLocationCoordinate2D) coordinates {
    
    CLLocationCoordinate2D coordinate = coordinates;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    
    __weak DescriptionViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray* _Nullable placemarks, NSError * _Nullable error) {
            
            NSString *message = nil;
            NSString *addressString = nil;
            
            if (error) {
                
                message = [error description];
                
            } else {
                
                if ([placemarks count] > 0) {
                    
                    MKPlacemark *placeMark = [placemarks firstObject];
                    NSArray *lines = [placeMark.addressDictionary mutableArrayValueForKey:@"FormattedAddressLines"];
                    addressString = [lines componentsJoinedByString:@","];
                    NSLog(@"Address: %@", addressString);
                    
                }  else {
                    
                    message = @"No Placemarks Found";
                }
                
                weakSelf.address = addressString;
                [weakSelf.tableView reloadData];
            }
            
        }];
    });
    
}

#pragma mark - Action

- (void)cancelAction:(UIBarButtonItem *) sender {
    
    [self.delegate dismissPopoverController:self];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
        switch (indexPath.row) {
            case 0: cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", self.person.name];
                break;
            case 1: cell.textLabel.text = [NSString stringWithFormat:@"Surname: %@", self.person.lastName];
                break;
            case 2: cell.textLabel.text = [NSString stringWithFormat:@"Date of birth: %@", self.person.subtitle];
                break;
            case 3: cell.textLabel.text = [NSString stringWithFormat:@"Gender: %@", self.person.gender ? @"Male" : @"Female"];
                break;
            case 4: cell.textLabel.text = [NSString stringWithFormat:@"Address: %@", self.address];
                break;
                
        }
    
    return cell;
    
}

@end
