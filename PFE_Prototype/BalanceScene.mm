//
//  BalanceScene.m
//
//  The tower balance game scene
//

#import "BalanceScene.h"


@implementation BalanceScene

-(id) initGameScene : (GameData*) i_pGameData
{
    if(!i_pGameData)
    {
        NSLog(@"Fatal error : constructions scene init failed");
        return nil;
    }
    else if (self = [super init])
    {
        self._pGameData = i_pGameData;
        
        // Analyze game data
        
        // init layers
    }
    
    return self;
}


-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return nil;
}


@end