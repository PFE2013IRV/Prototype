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
#import "LevelVisitor.h"


@interface SunLayer : CCLayer {
    ccColor4B _aSunColors[9];
}
@property  int
_tailleGradient,
_nbSecondToPlay,
_currentMomentOfDay,
_nbDecrement;
@property  float _timeScale,_velocityFactor;
@property CGPoint _previousGradientCenter;
@property  CGFloat _sunDisplayHeight,_sunDisplayWidth;
@property (nonatomic,strong) CCSprite* _pSoleil;
@property (nonatomic,strong) CCSprite* _pGradientCenter;
@property float _incrementAlpha;
@property  bool _animationDirection;
@property  int _sceneMod;

@property ccColor4B _currentSunColor;
@property ccColor4B _aimedSunColor;


-(id) init;
-(void) rotationGradient;
-(void) initColorsOfSun;
-(void) changeSunColor:(ccTime)i_dt;
-(void) genSunGradient:(ccTime)i_dt;
-(CCTexture2D *)createSunTexturetextureWidth:(float)i_textureWidth textureHeight:(float)i_textureHeight center:(CGPoint)i_center;
-(void) ManageSunConstruction;
-(void)ManageSunBalance: (ccColor4B) i_currentSunColor;



@end