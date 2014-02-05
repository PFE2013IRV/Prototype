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
    }
    
    return self;
}
-(int) Size
{
   return( [_aBlocs count]);
}
    
    
@end
