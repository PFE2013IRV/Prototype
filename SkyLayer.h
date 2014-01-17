//
//  SkyLayer.h
//
//  Definition of the sky layer. This class implements several mechnanisms for the dynamic sky
//  (gradients, interpolation with noise image...)
//

#import <GameKit/GameKit.h>


#import "cocos2d.h"
#import "CCRotationAround.h"
#import "GlobalConfig.h"


// BackgroundLayer
@interface SkyLayer : CCLayer
{
    int _aTimeScale[9];
    ccColor4B _aPaintColors[10];
    
    
}

-(id) init;
-(void) changeBackground:(ccTime)i_dt;
-(void) genBackground;
-(void) initColorsOfDay;
-(void) ManageBackgroundConstruction;
-(void) ManageBackgroundBalance;
-(CCTexture2D *)spriteWithColor:(ccColor4F)i_bgColor textureWidth:(float)i_textureWidth textureHeight:(float)i_textureHeight;






@property (nonatomic,strong) CCAnimation* _pAnimation;
@property (nonatomic,strong) CCAnimate* _pAnimate;
@property (nonatomic,strong) CCSprite* _pBackground;
@property  CGFloat _backgroundHeight,_backgroundWidth;
@property  float _velocityFactor;
@property  int _sceneMod;

@property  int    _nbSecondToPlay,
_nbSecondPlayed,
_currentMomentOfDay,
_incrementR,
_incrementG,
_incrementB;

@property  ccColor4B _currentBackgroundColor;
@property  ccColor4B _aimedBackgroundColor;





@end
