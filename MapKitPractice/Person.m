//
//  Person.m
//  MapKitPractice
//
//  Created by Syngmaster on 12/05/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "Person.h"
#import "NSDate+RandomDate.h"

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

static int namesCount = 50;

@implementation Person

+(Person *)generateRandomPerson {
    
    Person *person = [[Person alloc] init];
    
    person.name = firstNames[arc4random() % namesCount];
    person.lastName = lastNames[arc4random() % namesCount];
    person.gender = arc4random() % 2;
    
    CLLocationCoordinate2D location;
    location.latitude = (((float)arc4random()/0x100000000)*(53.389805-53.349805) + 53.349805);
    location.longitude = (((float)arc4random()/0x100000000)*((-6.29031)-(-6.26031)) + (-6.26031));
    person.coordinate = location;
    
    person.title = [NSString stringWithFormat:@"%@ %@", person.name, person.lastName];
    NSDateFormatter *dateformater = [[NSDateFormatter alloc]init];
    
    [dateformater setDateFormat:@"dd MMM yyyy"];
    
    NSDate *date = [[NSDate alloc]init];
    
    person.subtitle = [dateformater stringFromDate:[date randomDateInYearOfDate]];
    
    return person;
}

@end
