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
}

-(void) moveWindGod : (id) sender;

- (void) playWindStaticAnims : (id) sender;

- (void) playCuteAnim : (id) sender;

- (void) refreshWindGodInfo;

@property (nonatomic,strong) GameData* _pCurrGameData;
@property (nonatomic,strong) WindGodData* _pGodData;


@end

