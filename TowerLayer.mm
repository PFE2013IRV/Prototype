//
//  TowerLayer.m
//
//  The layer that contains the tower. It is based on a TowerData.
//
//

#import "TowerLayer.h"
#import "LevelVisitor.h"

@implementation TowerLayer

@synthesize _pCurrentGameData;

-(id) init
{
    if(self = [super init])
    {
        self._aBlocsTowerSprite = [[NSMutableArray alloc] init];
        _pCurrentGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
    }
    
    return self;
}

@end
