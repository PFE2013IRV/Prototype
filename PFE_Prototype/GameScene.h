//
//  GameScene.h
//
//  Base class for the different game scenes.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SkyLayer.h"
#import "PlanetLayer.h"
#import "GameData.h"

@interface GameScene : CCScene {
    
}

// The game data for the game scene.
@property (nonatomic,strong) GameData* _pGameData;

// The sky layer is declared here because it is the same layer for all specializations of GameScene.
@property (nonatomic, strong) SkyLayer* _pSkyLayer;

@property (nonatomic,strong) PlanetLayer* _pPlanetLayer;

// init
-(id)init;

@end
