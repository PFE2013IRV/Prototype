//
//  WindGodLayer.h
//
//  This layer contains the wind god's sprites, spritesheets, animations.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AnimatedGodLayer.h"
#import "WindGodData.h"
#import "GameData.h"

@interface WindGodLayer : AnimatedGodLayer
{
    BOOL _godIsUp;
    CGPoint _currentPosition;
    float _runtime;
}

-(void) moveWindGod : (id) sender;

- (void) playWindStaticAnims : (id) sender;

- (void) playCuteAnim : (id) sender;

- (void) refreshWindGodInfo;

-(void) playWindGodAttackSequence : (id) sender;

@property (nonatomic,strong) GameData* _pCurrGameData;
@property (nonatomic,strong) WindGodData* _pGodData;


@end

