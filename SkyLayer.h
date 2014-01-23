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
   
    ccColor4B _aPaintColors[9];
    
    
}

-(id) init;
-(void) initConstruction;
-(void) initBalance;
-(void) changeBackground:(ccTime)i_dt;

-(void) initColorsOfDay;
-(void) ManageBackgroundConstruction;
-(void) ManageBackgroundBalance;








@property (nonatomic,strong) CCSprite* _pBackground;
@property  CGFloat _backgroundHeight,_backgroundWidth;
@property  float _velocityFactor,_timeScale;

@property  int _sceneMod;

@property  int    _nbSecondToPlay,
_nbSecondPlayed,
_currentMomentOfDay;

@property  ccColor4B _currentBackgroundColor;
@property  ccColor4B _aimedBackgroundColor;





@end
