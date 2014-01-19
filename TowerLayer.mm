//
//  TowerLayer.m
//
//  The layer that contains the tower. It is based on a TowerData.
//
//

#import "TowerLayer.h"


@implementation TowerLayer

-(id) init
{
    if(self = [super init])
    {
        self._aBlocsTowerSprite = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
