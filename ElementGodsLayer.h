//
//  ElementGodsLayer.h
//
//  This layer implements the animation sequences for all the elementary gods (fire, water, earth)
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AnimatedGodLayer.h"
#import "GameData.h"

@interface ElementGodsLayer : AnimatedGodLayer
{    
    // Anger
    BOOL _isAngry;
    // Current god
    GodType _eCurrentGod;
}

// This method plays a sequence of static anims (default) for
// the current god
- (void) playElementaryStaticAnims;

// This method launches the anger animation for the current god
- (void) playAngerAnim;

// This method refreshes the elementary god information by accessing
// the current game data;
- (void) refreshElementaryGodInfo;

// Add Flames with bouton (for test)
- (void) addGodParticle:(id)i_boutonClic;

// Add flames with upset...
- (void) addGodParticle;


// Flames when god is upset
@property (nonatomic, strong) CCParticleSystem* _pGodParticle;
@property (nonatomic,strong) GameData* _pCurrGameData;
@property (nonatomic,strong) GodData* _pGodData;


@end
