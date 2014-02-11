//
//  GodWrathLayer.m
//  PFE_Prototype
//
//  Created by Maximilien on 1/25/14.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "GodWrathLayer.h"
#import "LevelVisitor.h"
#import "GameData.h"

@implementation GodWrathLayer

@synthesize _isAnimAngryBeingCancelled,_isAnimAngryBeingLaunched,_lockAnim;
@synthesize _pCurrGameData,_pGodData;
@synthesize _godWrathDisplayHeight,_godWrathDisplayWidth;
@synthesize _velocityFactor;
@synthesize _annimationDuration,_incrementAlpha;
@synthesize _nbAnnimationStep;
@synthesize _pGodWrathAnnimation;
@synthesize _colorRWrath,_colorGWrath,_colorBWrath;
@synthesize _maxAlpha;

-(id) init
{
if( (self=[super init]) )
{
    
    _pCurrGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
    _godWrathDisplayWidth = BACKGROUND_WIDTH;
    _godWrathDisplayHeight = BACKGROUND_HEIGHT;
    _annimationDuration = 2.0;
    _velocityFactor = 0.1;
    _maxAlpha = 200;
    _isAnimAngryBeingCancelled=YES;
    _isAnimAngryBeingLaunched=NO;
    _incrementAlpha = (float)_maxAlpha/(_annimationDuration/_velocityFactor);
        _colorRWrath=20;
    _colorGWrath=20;
    _colorBWrath=30;
    _nbAnnimationStep=1;
    _lockAnim = NO;
    
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:_godWrathDisplayWidth height:_godWrathDisplayHeight];
    [rt beginWithClear:_colorRWrath g:_colorGWrath b:_colorBWrath a:0];
    [rt end];
    CGSize winSize = [[CCDirector sharedDirector]winSize];

    _pGodWrathAnnimation = [CCSprite spriteWithTexture:rt.sprite.texture];
    _pGodWrathAnnimation.position = (ccp(_godWrathDisplayWidth/2,_godWrathDisplayHeight/2+winSize.height-_godWrathDisplayHeight));

    [self addChild:_pGodWrathAnnimation];
    
    [self schedule:@selector(skyGodWrath:)interval:_velocityFactor*2];
    
}
return self;
}
-(void) skyWarthAnnimation:(ccTime)i_dt
{
    float currentAlpha = _nbAnnimationStep*_incrementAlpha;
    if(currentAlpha > _maxAlpha)
    {
        [self unschedule:@selector(skyWarthAnnimation:)];
        _lockAnim=NO;;
        _nbAnnimationStep=1;
        
    }
    else if(_lockAnim)
    {
        ccColor4B color4B = ccc4(_colorRWrath,_colorGWrath,_colorBWrath,_nbAnnimationStep*_incrementAlpha);
        ccColor4F WrathColor =  ccc4FFromccc4B(color4B);
        self.shaderProgram = [[CCShaderCache sharedShaderCache]programForKey:kCCShader_PositionColor];
        CC_NODE_DRAW_SETUP();
        CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:_godWrathDisplayWidth height:_godWrathDisplayHeight];
        [rt beginWithClear:WrathColor.r g:WrathColor.g b:WrathColor.b a:WrathColor.a];
        
        glBlendFunc(GL_SRC_COLOR, GL_DST_COLOR);
        [rt end];
        
        [_pGodWrathAnnimation setTexture:rt.sprite.texture];
        _nbAnnimationStep++;
    }
}
-(void) skyUnWarthAnnimation:(ccTime)i_dt
{
    float currentAlpha  = _maxAlpha - (float)_nbAnnimationStep*_incrementAlpha;
    if(currentAlpha<=0)
    {
        [self unschedule:@selector(skyUnWarthAnnimation:)];
        _lockAnim=NO;
        _nbAnnimationStep=1;
    }
    else if(_lockAnim)
    {
        ccColor4B color4B = ccc4(_colorRWrath,_colorGWrath,_colorBWrath,currentAlpha);
        ccColor4F WrathColor =  ccc4FFromccc4B(color4B);
        self.shaderProgram = [[CCShaderCache sharedShaderCache]programForKey:kCCShader_PositionColor];
        CC_NODE_DRAW_SETUP();
        CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:_godWrathDisplayWidth height:_godWrathDisplayHeight];
        [rt beginWithClear:WrathColor.r g:WrathColor.g b:WrathColor.b a:WrathColor.a];
        
        glBlendFunc(GL_SRC_COLOR, GL_DST_COLOR);
        [rt end];
        
        [_pGodWrathAnnimation setTexture:rt.sprite.texture];
        _nbAnnimationStep++;
    }
   

}

-(void) skyGodWrath:(ccTime)i_dt
{
    // On regarde à quel dieu on à faire et remet à jour la variable de colère
    self._pGodData = [self._pCurrGameData getCurrentGod];
    
    if(_pGodData._isAngry && !_isAnimAngryBeingLaunched)
    {
        _isAnimAngryBeingCancelled=NO;
        _isAnimAngryBeingLaunched = YES;
        _lockAnim= YES;
        if(_pGodData._eGodType==GOD_TYPE_FIRE )
        {
            [self unschedule:@selector(skyUnWarthAnnimation:)];
            [self schedule:@selector(skyWarthAnnimation:)interval:_velocityFactor];
        }
    }
    
    else if(!_pGodData._isAngry && !_isAnimAngryBeingCancelled)
    {
        _isAnimAngryBeingLaunched = NO;
        _isAnimAngryBeingCancelled = YES;
        _lockAnim=YES;
        if(_pGodData._eGodType == GOD_TYPE_FIRE)
        {
            [self unschedule:@selector(skyWarthAnnimation:)];
            [self schedule:@selector(skyUnWarthAnnimation:)interval:_velocityFactor];
        }
    }
    
}
-(void)ReSchedule
{
     [self schedule:@selector(skyGodWrath:)interval:_velocityFactor*2];
}

@end
