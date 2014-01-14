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
@synthesize _aFireParticles;
@synthesize _aWaterParticles;
@synthesize _aWindParticles;
@synthesize _pGodFireFront;
@synthesize _pGodFireBehind;
@synthesize _pLinkBlocs;
@synthesize _pTowerLightColumn;


-(id) init
{
	if( (self=[super init]) )
    {
        _aFireParticles = [[NSMutableArray alloc] init];
        _aWaterParticles = [[NSMutableArray alloc] init];
        _aWindParticles = [[NSMutableArray alloc] init];

        //        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Bouton pour add fire attack
        CCMenuItemImage *addParticleFireButton = [CCMenuItemImage itemWithNormalImage:@"addFire.png" selectedImage:@"addFire.png" target:self selector:@selector(addFireParticle:)];
        addParticleFireButton.position = ccp(50, 0);
        
        // Bouton add water attack
        CCMenuItemImage *addParticleWaterButton = [CCMenuItemImage itemWithNormalImage:@"addWater.png" selectedImage:@"addWater.png" target:self selector:@selector(addWaterParticle:)];
        addParticleWaterButton.position = ccp(100, 0);
        
        // Bouton add wind attack
        CCMenuItemImage *addParticleWindButton = [CCMenuItemImage itemWithNormalImage:@"addWind.png" selectedImage:@"addWind.png" target:self selector:@selector(addWindParticle:)];
        addParticleWindButton.position = ccp(150, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleFireButton, addParticleWaterButton, addParticleWindButton, nil];
        addMenu.position = ccp(0, 20);
        
        
        // ajoute le menu
        [self addChild:addMenu];
        
        
        [self scheduleUpdate];
	}
	return self;
}

-(void)addFireParticle:(id)boutonClic
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // creer via appli ipad
    // CCParticleSystemQuad *pFireParticle = ;
    // [_aFireParticles addObject:pFireParticle];
    
    // [self addChild:pFireParticle];
    
}

-(void)addWaterParticle:(id)boutonClic
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // creer via appli ipad
    // CCParticleSystemQuad *pWaterParticle = ;
    // [_aWaterParticles addObject:pWaterParticle];
    
    // [self addChild:pWaterParticle];
    
}

-(void)addWindParticle:(id)boutonClic
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // creer via appli ipad
    // CCParticleSystemQuad *pWindParticle = ;
    // [_aWindParticles addObject:pWindParticle];
    
    // [self addChild:pWindParticle];
    
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
    
}

@end