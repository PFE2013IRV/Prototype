//
//  SunLayer.h
//  PFE_Prototype
//
//  Created by Maximilien on 1/16/14.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCRotationAround.h"
#import "GlobalConfig.h"

@interface SunLayer : CCLayer {
     int _aTimeScale[9];
     ccColor4B _aSunColors[9];
}
@property  int
_incrementSunR,
_incrementSunG,
_incrementSunB,
_incrementSunA,
_tailleGradient,
_nbSecondToPlay,
_nbSecondPlayed,
_currentMomentOfDay;
@property  float _velocityFactor;
@property  CGFloat _sunDisplayHeight,_sunDisplayWidth;
@property (nonatomic,strong) CCSprite* _pSoleil;
@property (nonatomic,strong) CCSprite* _pGradientCenter;
@property  bool _animationDirection;
@property  int _sceneMod;

@property ccColor4B _currentSunColor;
@property ccColor4B _aimedSunColor;


-(id) init;
-(void) rotationGradient;
-(void) initColorsOfSun;
-(void) changeSun:(ccTime)i_dt;
-(void) genSun;
-(CCTexture2D *)createSunTexture:(ccColor4F)i_bgColor textureWidth:(float)i_textureWidth textureHeight:(float)i_textureHeight;
-(void) ManageSunConstruction;
-(void) ManageSunBalance;



@end
