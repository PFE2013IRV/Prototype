//
//  GameScene.h
//
//  Base class for the different game scenes.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SkyLayer.h"
#import "SunLayer.h"
#import "PlanetLayer.h"
#import "ElementGodsLayer.h"
#import "WindGodLayer.h"
#import "FireAttackLayer.h"
#import "WindAttackLayer.h"
#import "DustLayerFront.h"
#import "DustLayerBack.h"
#import "GameData.h"
#import "StarsLayer.h"
#import "AnimatedBackground.h"
#import "CloudsFrontTop.h"
#import "CloudsBack.h"

@interface GameScene : CCScene {
    
}

// The game data for the game scene.
@property (nonatomic,strong) GameData* _pGameData;

// The sky layer is declared here because it is the same layer for all specializations of GameScene.
@property (nonatomic, strong) SkyLayer* _pSkyLayer;

// Sun layer is on top of the sky layer
@property (nonatomic,strong) SunLayer* _pSunLayer;

// The planet layer is common to both game scene modes
@property (nonatomic, strong) PlanetLayer* _pPlanetLayer;

@property(nonatomic, strong) DustLayerFront* _pDustLayerFront;

@property(nonatomic, strong) DustLayerBack* _pDustLayerBack;

@property(nonatomic, strong) StarsLayer* _pStarsLayer;




// init
-(id)init;

@end
