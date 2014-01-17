//
//  SunLayer.m
//  PFE_Prototype
//
//  Created by Maximilien on 1/16/14.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "SunLayer.h"


@implementation SunLayer

@synthesize _incrementSunR,
_incrementSunG,
_incrementSunB,
_tailleGradient,
_nbSecondToPlay,
_nbSecondPlayed,
_currentMomentOfDay;
@synthesize _pSoleil,_pGradientCenter;
@synthesize _sunDisplayHeight,_sunDisplayWidth;
@synthesize _velocityFactor;
@synthesize _animationDirection;
@synthesize _currentSunColor,_aimedSunColor;
@synthesize _sceneMod;

-(id) init
{
    if( (self=[super init]) )
    {
        
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        //Taille à changer!!!
        _sunDisplayHeight = winSize.height;
        _sunDisplayWidth = winSize.width;
	}
	return self;
}
-(void) initColorsOfSun
{
    _nbSecondToPlay = 120;
    _velocityFactor = 0.1;
    _nbSecondPlayed = 0;
    _animationDirection=1;
    
    
    
    /* Base couleur */
    ccColor4B sunDawn = ccc4(236, 239, 161, 255);
    ccColor4B sunMorning = ccc4(239, 225, 161, 255);
    ccColor4B sunMiddleMorning = ccc4(237, 219, 133, 255);
    ccColor4B sunNoon = ccc4(228, 195, 114, 255);
    ccColor4B sunAfternoon = ccc4(227, 180, 68, 255);
    ccColor4B sunEvening = ccc4(227, 165, 68, 255);
    ccColor4B sunNight = ccc4(227, 139, 68, 255);
    ccColor4B sunMidnight = ccc4(212, 106, 64, 255);
    ccColor4B sunDark = ccc4(212, 106, 64, 0);
 
    _aSunColors[0] = sunDawn;
    _aSunColors[1] = sunMorning;
    _aSunColors[2] = sunMiddleMorning;
    _aSunColors[3] = sunNoon;
    _aSunColors[4] = sunAfternoon;
    _aSunColors[5] = sunEvening;
    _aSunColors[6] = sunNight;
    _aSunColors[7] = sunMidnight;
    _aSunColors[8] = sunDark;
    _aSunColors[9] = sunDawn;
    
    for(int i=1; i<=9;i++)
    {
        _aTimeScale[i-1] = _nbSecondToPlay/9*i;
    }
    
    
    _currentMomentOfDay=0;
        _currentSunColor = _aSunColors[0];
    _aimedSunColor = _aSunColors[_currentMomentOfDay+1];
    
    _incrementSunR = (_aimedSunColor.r - _currentSunColor.r)/ (_nbSecondToPlay/10);
    _incrementSunG = (_aimedSunColor.g - _currentSunColor.g)/ (_nbSecondToPlay/10);
    _incrementSunB = (_aimedSunColor.b - _currentSunColor.b)/ (_nbSecondToPlay/10);
    
    
    _pGradientCenter = [[CCSprite alloc]init];
    
    if(_sceneMod == SCENE_MODE_CONSTRUCTION)
    {
        _pGradientCenter.position = ccp(_pGradientCenter.contentSize.width/2,_sunDisplayHeight);
        [self addChild:_pGradientCenter];
        [self rotationGradient];
    }
    else
    {
        _pGradientCenter.position = ccp(_sunDisplayWidth,_sunDisplayHeight);
    }
}
-(void) rotationGradient
{
    CGPoint RotationPoint = ccp(_sunDisplayWidth/2,_sunDisplayHeight);
    float radius = sqrtf((_pGradientCenter.position.x-RotationPoint.x)*(_pGradientCenter.position.x-RotationPoint.x)+ (_pGradientCenter.position.y-RotationPoint.y)*(_pGradientCenter.position.y-RotationPoint.y));
    
    
    CCAction *moveGradient;
    float rotationDuration = _nbSecondToPlay*_velocityFactor;
    
    if(_animationDirection)
    {
        
        moveGradient = [CCRotationAround actionWithDuration:rotationDuration position:RotationPoint radius:-radius direction:-1 rotation:1 angle:0];
        _animationDirection=0;
    }
    else
    {
        moveGradient = [CCRotationAround actionWithDuration:rotationDuration position:RotationPoint radius:radius direction:-1 rotation:-1 angle:0];
        _animationDirection=1;
    }
    
    [_pGradientCenter runAction:moveGradient];
    
}

-(void) genSun {
    
    ccColor4F bgColor =  ccc4FFromccc4B(_currentSunColor);
    CCTexture2D *newTexture = [self createSunTexture:bgColor textureWidth:_sunDisplayWidth textureHeight:_sunDisplayHeight];
    
    if (!_pSoleil)
    {
        _pSoleil = [CCSprite spriteWithTexture:newTexture];
        _pSoleil.position = (ccp(_sunDisplayWidth/2,_sunDisplayHeight/2));
        [self addChild:_pSoleil ];
    }
    else
    {
        [_pSoleil setTexture:newTexture];
    }
}


-(CCTexture2D *)createSunTexture:(ccColor4F)bgColor textureWidth:(float)textureWidth textureHeight:(float)textureHeight {
    
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:textureWidth height:textureHeight];
    [rt beginWithClear:0 g:0 b:0 a:0];
    
    //Dessin dans la texture
    /* Gradient */
    
     self.shaderProgram = [[CCShaderCache sharedShaderCache]programForKey:kCCShader_PositionColor];
     CC_NODE_DRAW_SETUP();
     float gradientAlpha = 1.f;
     int nbSlices = 360;
     float incr = (float) (2* M_PI / nbSlices);
    float radius = 600;
    
     CGPoint vertices[nbSlices+2];
     ccColor4F colors[nbSlices+2];
     
     //Le premier point est le centre du cercle , la position du centre du gradient
     vertices[0] = CGPointMake(_pGradientCenter.position.x,_pGradientCenter.position.y);
    
     colors[0] = (ccColor4F){bgColor.r,bgColor.g,bgColor.b,gradientAlpha};
     for(int i=0;i<=nbSlices;i++)
     {
     float angle= incr * i;
     float x = (float) cosf(angle)*radius + _pGradientCenter.position.x;
     float y = (float) sinf(angle)*radius + _pGradientCenter.position.y;
     vertices[i+1] = CGPointMake(x, y);
     colors[i+1] = (ccColor4F){bgColor.r,bgColor.g,bgColor.b,0};
     
     }
     
     ccGLEnableVertexAttribs(kCCVertexAttribFlag_Position | kCCVertexAttribFlag_Color);
    
    glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, 0, colors);
    glBlendFunc(GL_SRC_COLOR, GL_DST_COLOR);
    glDrawArrays(GL_TRIANGLE_FAN, 0, (GLsizei)nbSlices+2);
    
    
    [rt end];
    
    return rt.sprite.texture;
    
    
}

-(void) changeSun:(ccTime)i_dt
{
    
    _nbSecondPlayed ++;
    if(_nbSecondPlayed < _aTimeScale[_currentMomentOfDay])
    {
        ccColor4B newColor = ccc4(_currentSunColor.r + _incrementSunR, _currentSunColor.g + _incrementSunG, _currentSunColor.b + _incrementSunB, 255);
        _currentSunColor = newColor;
        
    }
    else
    {
        _currentMomentOfDay++;
        if(_currentMomentOfDay <9)
        {
            
            _aimedSunColor = _aSunColors[_currentMomentOfDay+1];
            _incrementSunR = (_aimedSunColor.r - _currentSunColor.r)/ (_aTimeScale[_currentMomentOfDay]-_aTimeScale[_currentMomentOfDay-1]);
            _incrementSunG = (_aimedSunColor.g - _currentSunColor.g)/ (_aTimeScale[_currentMomentOfDay]-_aTimeScale[_currentMomentOfDay-1]);
            _incrementSunB = (_aimedSunColor.b - _currentSunColor.b)/(_aTimeScale[_currentMomentOfDay]-_aTimeScale[_currentMomentOfDay-1]);
            
            ccColor4B newColor = ccc4(_currentSunColor.r + _incrementSunR, _currentSunColor.g + _incrementSunG, _currentSunColor.b + _incrementSunB, 255);
            _currentSunColor = newColor;
            

            
        }
        else
        {
            _currentMomentOfDay = 0;
            _currentSunColor = _aSunColors[0];
            _nbSecondPlayed=0;
            
            _aimedSunColor = _aSunColors[_currentMomentOfDay+1];
            _incrementSunR = (_aimedSunColor.r - _currentSunColor.r)/ (_aTimeScale[0]);
            _incrementSunG = (_aimedSunColor.g - _currentSunColor.g)/  (_aTimeScale[0]);
            _incrementSunB = (_aimedSunColor.b - _currentSunColor.b)/ (_aTimeScale[0]);
            
            if(_sceneMod == SCENE_MODE_CONSTRUCTION)
            {
                [self rotationGradient];
            }

            
            
            
        }
    }
    [self genSun ];
}

-(void)ManageSunConstruction
{
    self._sceneMod = SCENE_MODE_CONSTRUCTION;
    [self initColorsOfSun];
    
    [self schedule:@selector(changeSun:)interval:_velocityFactor];
    
}
-(void)ManageSunBalance
{
    self._sceneMod = SCENE_MODE_BALANCE;
    [self initColorsOfSun];
    
    //On prend une couleur aléatoire comme couleur de fond parmis le tableau des couleurs
    int alea = arc4random() %9;
    self._aimedSunColor = _aSunColors[alea];
    [self genSun];
    
}


@end
