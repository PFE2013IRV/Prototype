//
//  ParticleLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 10/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "ParticleLayer.h"


@implementation ParticleLayer

@synthesize _isGodUpset;
@synthesize _isGodFireOn;
@synthesize _pGodFireFront;
@synthesize _pGodFireBehind;
@synthesize _pLinkBlocs;
@synthesize _pTowerLightColumn;
@synthesize _pGodParticle;


-(id) init
{
	if( (self=[super init]) )
    {
        _isGodUpset = false;
        _isGodFireOn = false;
        // Bouton add fire attack
        CCMenuItemImage *addParticleFireButton = [CCMenuItemImage itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton.png" target:self selector:@selector(addFireParticle:)];
        addParticleFireButton.position = ccp(50, 0);
        
        // Bouton add wind attack
        CCMenuItemImage *addParticleWindButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addWindParticle:)];
        addParticleWindButton.position = ccp(100, 0);
        
        // Bouton God
        CCMenuItemImage *addParticleGodFireButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addGodParticle:)];
        addParticleGodFireButton.position = ccp(150, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleFireButton, addParticleWindButton, addParticleGodFireButton, nil];
        addMenu.position = ccp(0, 20);
        
        
        // ajoute le menu
        [self addChild:addMenu];
        
        
        //[self scheduleUpdate];
	}
	return self;
}

-(void)addFireParticle:(id)i_boutonClic
{
    // créé via appli
    CCParticleSystem *pFireParticle=[[[CCParticleSystemQuad alloc] initWithTotalParticles:381] autorelease];
    ///////**** Assignment Texture Filename!  ****///////
    CCTexture2D *texture=[[CCTextureCache sharedTextureCache] addImage:@"Fire_Particle.png"];
    pFireParticle.texture=texture;
    pFireParticle.emissionRate=190.50;
    pFireParticle.angle=90.0;
    pFireParticle.angleVar=360.0;
    ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE};
    pFireParticle.blendFunc=blendFunc;
    pFireParticle.duration=-1.00;
    pFireParticle.emitterMode=kCCParticleModeGravity;
    ccColor4F startColor={0.80,0.23,0.16,1.00};
    pFireParticle.startColor=startColor;
    ccColor4F startColorVar={0.00,0.00,0.20,0.10};
    pFireParticle.startColorVar=startColorVar;
    ccColor4F endColor={0.00,0.00,0.00,1.00};
    pFireParticle.endColor=endColor;
    ccColor4F endColorVar={0.00,0.00,0.00,0.00};
    pFireParticle.endColorVar=endColorVar;
    pFireParticle.startSize=60.00;
    pFireParticle.startSizeVar=10.00;
    pFireParticle.endSize=-1.00;
    pFireParticle.endSizeVar=0.00;
    pFireParticle.gravity=ccp(-200.00,200.00);
    pFireParticle.radialAccel=-76.46;
    pFireParticle.radialAccelVar=0.00;
    pFireParticle.speed=18;
    pFireParticle.speedVar= 5;
    pFireParticle.tangentialAccel=-15;
    pFireParticle.tangentialAccelVar= 0;
    pFireParticle.totalParticles=381;
    pFireParticle.life=2.00;
    pFireParticle.lifeVar=1.00;
    pFireParticle.startSpin=0.00;
    pFireParticle.startSpinVar=0.00;
    pFireParticle.endSpin=0.00;
    pFireParticle.endSpinVar=0.00;
    pFireParticle.position=ccp(240.00,160.00);
    pFireParticle.posVar=ccp(0.00,0.00);
    
    [self addChild:pFireParticle];
    
}

-(void)addWindParticle:(id)i_boutonClic
{
    CCParticleSystem *pWindParticle=[[[CCParticleSystemQuad alloc] initWithTotalParticles:1937] autorelease];
    ///////**** Assignment Texture Filename!  ****///////
    CCTexture2D *texture=[[CCTextureCache sharedTextureCache] addImage:@"Wind_Particle.png"];
    pWindParticle.texture=texture;
    pWindParticle.emissionRate=368.04;
    pWindParticle.angle=0.0;
    pWindParticle.angleVar=0.0;
    ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA};
    pWindParticle.blendFunc=blendFunc;
    pWindParticle.duration=-1.00;
    pWindParticle.emitterMode=kCCParticleModeGravity;
    ccColor4F startColor={0.81,0.75,0.80,1.00};
    pWindParticle.startColor=startColor;
    ccColor4F startColorVar={0.00,0.00,0.00,0.00};
    pWindParticle.startColorVar=startColorVar;
    ccColor4F endColor={0.66,0.66,0.66,1.00};
    pWindParticle.endColor=endColor;
    ccColor4F endColorVar={0.00,0.00,0.00,0.00};
    pWindParticle.endColorVar=endColorVar;
    pWindParticle.startSize=18.37;
    pWindParticle.startSizeVar=5.00;
    pWindParticle.endSize=-1.00;
    pWindParticle.endSizeVar=5.00;
    pWindParticle.gravity=ccp(313.44,0.00);
    pWindParticle.radialAccel=0.00;
    pWindParticle.radialAccelVar=1.00;
    pWindParticle.speed=372;
    pWindParticle.speedVar=1000;
    pWindParticle.tangentialAccel= 0;
    pWindParticle.tangentialAccelVar= 1;
    pWindParticle.totalParticles=1937;
    pWindParticle.life=5.26;
    pWindParticle.lifeVar=15.00;
    pWindParticle.startSpin=2.25;
    pWindParticle.startSpinVar=0.00;
    pWindParticle.endSpin=0.00;
    pWindParticle.endSpinVar=0.00;
    pWindParticle.position=ccp(0.00,0.00);
    pWindParticle.posVar=ccp(0.00,128.23);
    
    [self addChild:pWindParticle];
    
}

-(void)addGodParticle:(id)i_boutonClic
{
    _pGodParticle=[[[CCParticleSystemQuad alloc] initWithTotalParticles:127] autorelease];
    ///////**** Assignment Texture Filename!  ****///////
    CCTexture2D *texture=[[CCTextureCache sharedTextureCache] addImage:@"God_Particle.png"];
    _pGodParticle.texture=texture;
    _pGodParticle.emissionRate=940.66;
    _pGodParticle.angle=90.0;
    _pGodParticle.angleVar=10.0;
    ccBlendFunc blendFunc={GL_SRC_ALPHA,GL_ONE};
    _pGodParticle.blendFunc=blendFunc;
    _pGodParticle.duration=-1.00;
    _pGodParticle.emitterMode=kCCParticleModeGravity;
    ccColor4F startColor={0.88,0.21,0.05,1.00};
    _pGodParticle.startColor=startColor;
    ccColor4F startColorVar={0.00,0.00,0.00,0.00};
    _pGodParticle.startColorVar=startColorVar;
    ccColor4F endColor={0.00,0.00,0.00,1.00};
    _pGodParticle.endColor=endColor;
    ccColor4F endColorVar={0.00,0.00,0.00,0.00};
    _pGodParticle.endColorVar=endColorVar;
    _pGodParticle.startSize=54.00;
    _pGodParticle.startSizeVar=10.00;
    _pGodParticle.endSize=-1.00;
    _pGodParticle.endSizeVar=0.00;
    _pGodParticle.gravity=ccp(0.00,0.00);
    _pGodParticle.radialAccel=0.00;
    _pGodParticle.radialAccelVar=0.00;
    _pGodParticle.speed=123;
    _pGodParticle.speedVar=20;
    _pGodParticle.tangentialAccel= 0;
    _pGodParticle.tangentialAccelVar= 0;
    _pGodParticle.totalParticles=856;
    _pGodParticle.life=0.91;
    _pGodParticle.lifeVar=0.25;
    _pGodParticle.startSpin=0.00;
    _pGodParticle.startSpinVar=0.00;
    _pGodParticle.endSpin=0.00;
    _pGodParticle.endSpinVar=0.00;
    _pGodParticle.position=ccp(126.78,596.00);
    _pGodParticle.posVar=ccp(110.00,20.00);
    
    [self addChild:_pGodParticle];
    _isGodFireOn = true;
}

-(void)godIsUpset:(id)i_boutonCLic
{
    _isGodUpset = !_isGodUpset;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void)update:(ccTime)delta
{
    if(_isGodUpset && !_isGodFireOn){
        //[self addGodParticle];
    }
    else if(!_isGodUpset && _isGodFireOn){
        [self removeChild:_pGodParticle];
        _isGodFireOn = false;
    }
    
}

@end