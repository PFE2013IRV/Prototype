//
//  TowerData.m
//  ProjectTower
//
//  This class provides a data model for the tower
//


#import "TowerData.h"

@implementation TowerData
@synthesize _aBlocs;


-(id) init
{
    if(self = [super init])
    {
        _aBlocs = [[NSMutableArray alloc] init];
        NSLog(@"TowerData init succeeded. Empty tower is ready to be built !");
    }
    
    return self;
}

@end
