//
//  GameData.m
//
//
//  This class provides the in-game data. This includes the tower's geometry,
//  the current god and the next one's to come, the time data, the level's goal,
//  the risk calculation...
//

#import "GameData.h"

@implementation GameData

@synthesize _aGodData;
@synthesize _eGameSceneMode;
@synthesize _pTowerData;
@synthesize _pWindGodData;
@synthesize winHeight = _winHeight;

-(id) initGameData : (GameSceneMode) i_eGameSceneMode withTowerData: (TowerData*) i_pTowerData
           withGods: (NSArray*) i_aGodData
{
    if(!(i_eGameSceneMode == SCENE_MODE_CONSTRUCTION || i_eGameSceneMode == SCENE_MODE_BALANCE))
    {
        [NSException raise:NSInternalInconsistencyException format:@"Fatal Error : game mode is unknown."];
    }
    else if(!i_pTowerData)
    {
        [NSException raise:NSInternalInconsistencyException format:@"Fatal Error : tower data is required"];
    }
    else if(!i_aGodData)
    {
        [NSException raise:NSInternalInconsistencyException format:@"Fatal Error : god data is required"];
    }
    else
    {
        if(!(i_aGodData.count > 0 && i_aGodData.count < 4))
        {
            [NSException raise:NSInternalInconsistencyException format:@"Fatal Error : please check the number of gods"];           
        }
        else
        {
            if(self = [super init])
            {
                // true init starts here
                _currentGodIndex = 0;
                _aGodData = i_aGodData;
                _eGameSceneMode = i_eGameSceneMode;
                _pTowerData = i_pTowerData;
                _pWindGodData = [[WindGodData alloc] init];
                _winHeight = 3000;
                
                NSLog(@"test");
            }
        }
    }
    
    return self;
}



-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

-(GodData*) getCurrentGod
{
    if(_aGodData.count > 0)
        return [_aGodData objectAtIndex:_currentGodIndex];
    
    else
        return nil;
        
}


@end
