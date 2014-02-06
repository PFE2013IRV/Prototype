//
//  SunLayer.m
//  PFE_Prototype
//
//  Created by Maximilien on 1/16/14.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "SunLayer.h"
#import "ConstructionScene.h"


@implementation SunLayer

@synthesize _tailleGradient,
            _nbSecondToPlay,
            _currentMomentOfDay,
            _nbDecrement;
@synthesize _pSoleil,_pGradientCenter;
@synthesize _sunDisplayHeight,_sunDisplayWidth;
@synthesize _previousGradientCenter;
@synthesize _timeScale,_velocityFactor,_incrementAlpha;
@synthesize _animationDirection;
@synthesize _currentSunColor,_aimedSunColor;
@synthesize _sceneMod;
@synthesize aleatoire;

-(id) init
{
    if( (self=[super init]) )
    {
        aleatoire = 4 + arc4random()%4;
	}
	return self;
}

-(void) initSunConstruction
{
    _sunDisplayHeight = BACKGROUND_HEIGHT;
    _sunDisplayWidth = BACKGROUND_WIDTH;
    _animationDirection=1;
    _tailleGradient=600;
    [self initColorsOfSun];
    
    
}
-(void) initSunBalance : (ccColor4B) i_currentSunColor
{
    
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    _sunDisplayHeight = winSize.height;
    _sunDisplayWidth = winSize.width;
    _animationDirection=1;
    _tailleGradient=600;
    if(i_currentSunColor.a!=0 || i_currentSunColor.b!=0 || i_currentSunColor.g!=0 || i_currentSunColor.r!=0)
    {
        
        _currentSunColor = i_currentSunColor;
    }
    else
    {
        int alea = arc4random() %9;
        _currentSunColor = _aSunColors[alea];
        
    }

    [self initColorsOfSun];
    
}
-(void) initColorsOfSun
{
    _nbSecondToPlay = GAME_TIME_CONSTRUCTION;
    _velocityFactor = 0.5;
    _incrementAlpha = 0.0;
    _nbDecrement = 0;
    
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
    
    _timeScale = (float)_nbSecondToPlay/8;
    
    _currentMomentOfDay=0;
    
    _aimedSunColor = _aSunColors[_currentMomentOfDay+1];
    
    
    _pGradientCenter = [[CCSprite alloc]init];
    
    if(_sceneMod == SCENE_MODE_CONSTRUCTION)
    {
        _currentSunColor = _aSunColors[0];
        _pGradientCenter.position = ccp(_pGradientCenter.contentSize.width/2,_sunDisplayHeight);
        [self addChild:_pGradientCenter];
        [self rotationGradient];
    }
    else
    {
        //On prend une couleur aléatoire comme couleur de fond parmis le tableau des couleurs
                _pGradientCenter.position = ccp(_sunDisplayWidth/2,_sunDisplayHeight/2);
    }
    [self initSun];
}

-(void) initSun
{
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:_sunDisplayWidth height:_sunDisplayHeight];
    [rt beginWithClear:_currentSunColor.r g:_currentSunColor.g b:_currentSunColor.b a:_currentSunColor.a];
    [rt end];
    
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    _pSoleil = [CCSprite spriteWithTexture:rt.sprite.texture];
    
    [_pSoleil setColor:ccc3(_currentSunColor.r, _currentSunColor.g, _currentSunColor.b)];
    _pSoleil.position = (ccp(_sunDisplayWidth/2,_sunDisplayHeight/2+winSize.height-_sunDisplayHeight));
   
    [self addChild:_pSoleil ];
}

-(void) rotationGradient
{
    int hauteurSoleil = 120;
    
    //Formule : -(-w^2 + 4*h^2)/(8*h)
    /* Trouver le centre du cercle en connaissant 3 points par lesquels ils passent
     1) (0,0)
     2) (width/2,hauteur)
     3) (width,0)
     Repère commencant en bas à gauche // (COCOS2D => haut a gauche)
     
     */
    float coordY = -(-pow(_sunDisplayWidth, 2) + 4*pow(hauteurSoleil, 2)) / (8*hauteurSoleil);
    
    int centerY =_sunDisplayHeight + coordY;
    float radius = coordY+hauteurSoleil;
    
    //On décale le point de rotation de manière à avoir une rotation plus basse par rapport à l'horizon
    CGPoint RotationPoint = ccp(_sunDisplayWidth/2,centerY);
    float demiAngle = atan(_sunDisplayWidth/2/(radius-hauteurSoleil));
    float angle = M_PI/2 - demiAngle;
    float angleRotation = 2* demiAngle;
    
    CCAction *moveGradient;
    float rotationDuration = _nbSecondToPlay;
    
    if(_animationDirection)
    {
        
        moveGradient = [CCRotationAround actionWithDuration:rotationDuration position:RotationPoint radius:-radius direction:-1 rotation:1 angle:-angle angleRotation:angleRotation];
        _animationDirection=0;
    }
    
    [_pGradientCenter runAction:moveGradient];
    
}

-(void) genSunGradient:(ccTime)dt {
    
    
   // NSLog(@"Passage dans le schedule du soleil ! ");
    CGPoint center = CGPointMake(_pGradientCenter.position.x, _pGradientCenter.position.y);
    //En fin de jeu on vérifie que la fonction n'est pas exécutée plus de fois que nécessaire:on s'arrete quand le soleil à disparue(alpha=0)
    if(255-_incrementAlpha*_nbDecrement <= 0)
    {
        [self unschedule:@selector(genSunGradient:)];
    }
    else
    {
    CCTexture2D *newTexture = [self createSunTexturetextureWidth:_sunDisplayWidth textureHeight:_sunDisplayHeight center:center];
    
    [_pSoleil setTexture:newTexture];
    }
    
}


-(CCTexture2D *)createSunTexturetextureWidth:(float)i_textureWidth textureHeight:(float)i_textureHeight center:(CGPoint)i_center {
    
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:i_textureWidth height:i_textureHeight];
    [rt beginWithClear:0 g:0 b:0 a:0];
    
    //Dessin dans la texture
    /* Gradient */
    
        ccColor4B color4B = ccc4(_pSoleil.color.r,_pSoleil.color.g,_pSoleil.color.b,255-_incrementAlpha*_nbDecrement);
    _currentSunColor = color4B;
      ccColor4F bgColor =  ccc4FFromccc4B(color4B);
    self.shaderProgram = [[CCShaderCache sharedShaderCache]programForKey:kCCShader_PositionColor];
    CC_NODE_DRAW_SETUP();
    
    if(_incrementAlpha!=0)
    {
        _nbDecrement++;
    }

    
    int nbSlices = 360;
    float incr = (float) (2* M_PI / nbSlices);
    float radius = _tailleGradient;
    
    CGPoint vertices[nbSlices+2];
    ccColor4F colors[nbSlices+2];
   
    
    //Le premier point est le centre du cercle , la position du centre du gradient
    vertices[0] = i_center;
    
    colors[0] = (ccColor4F){bgColor.r,bgColor.g,bgColor.b,bgColor.a};
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

-(void) changeSunColor:(ccTime)i_dt
{
    
    _aimedSunColor = _aSunColors[_currentMomentOfDay+1];
    
    if(_currentMomentOfDay <8)
    {
        if(_currentMomentOfDay==7)
        {
            _incrementAlpha = (float)255.0/(_timeScale/_velocityFactor);
        }
        CCAction *changeColor = [CCTintTo actionWithDuration:_timeScale red:_aimedSunColor.r green:_aimedSunColor.g blue:_aimedSunColor.b];
        [_pSoleil runAction:changeColor];
        _currentMomentOfDay++;
    }
    else
    {
        [self unschedule:@selector(changeSunColor:)];
        
    }
}

-(void)ManageSunConstruction
{
    self._sceneMod = SCENE_MODE_CONSTRUCTION;
    [self initSunConstruction];
    
    [self schedule:@selector(changeSunColor:)interval:_timeScale];
    [self schedule:@selector(genSunGradient:)interval:_velocityFactor];
    
    
}
-(void)ManageSunBalance: (ccColor4B) i_currentSunColor
{
    self._sceneMod = SCENE_MODE_BALANCE;
[self initSunBalance:i_currentSunColor];

    
    [self genSunGradient:nil];
    
}
-(void)ReSchedule
{
    [self schedule:@selector(changeSunColor:)interval:_timeScale];
    [self schedule:@selector(genSunGradient:)interval:_velocityFactor];
}


@end