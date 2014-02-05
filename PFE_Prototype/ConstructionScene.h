//
//  ConstructionScene.h
//
//  The construction game scene
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"
#import "GameSceneProtocol.h"
#import "MenuAndConstructionTowerLayer.h"
#import "GodWrathLayer.h"
#import "UpsetGodParticleLayer.h"
@interface ConstructionScene : GameScene <GameSceneProtocol>

// Game scene init with game data is requiered for every game scene.
// i_pGameData : the game data used to initialize the scene
// return value : self
-(id) initGameScene : (GameData*) i_pGameData;


// Basic init is re-implemented with NSException to be avoided
// return value : nil
-(id) init;

// Add Flames with bouton (for test)
- (void) addGodParticle:(id)i_boutonClic;

@property (nonatomic, strong) FireAttackLayer* _pFireAttackLayer;

@property (nonatomic, strong) WindAttackLayer* _pWindAttackLayer;

@property(nonatomic, strong) UpsetGodParticleLayer* _pUpsetGodParticleLayer;

@property (nonatomic, strong) ElementGodsLayer* _pElementGodsLayer;

@property (nonatomic, strong) MenuAndConstructionTowerLayer *pMenuAndTowerLayer;

@property (nonatomic,strong) GodWrathLayer *_pGodWrathLayer;

@property (nonatomic,strong) AnimatedBackground* _pBkg1;

@property (nonatomic,strong) AnimatedBackground* _pBkg2;

@end
