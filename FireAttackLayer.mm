//
//  FireAttackLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "FireAttackLayer.h"


@implementation FireAttackLayer

@synthesize _pFireParticle1;
@synthesize _pFireParticle2;
@synthesize _pFireParticle3;
@synthesize _pFireParticle4;
@synthesize _pFireParticle5;
@synthesize _aFireParticles;
@synthesize _pFireParticle6;

-(id) init
{
	if( (self=[super init]) )
    {
        //init particles
        [self initParticles];
        //init array
        _aFireParticles=[[NSMutableArray alloc]initWithObjects:_pFireParticle1,_pFireParticle2, _pFireParticle3, _pFireParticle4, _pFireParticle5, _pFireParticle6, nil];
        
        // Bouton add fire attack
        CCMenuItemImage *addParticleFireButton = [CCMenuItemImage itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton.png" target:self selector:@selector(addFireParticle:)];
        addParticleFireButton.position = ccp(30, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleFireButton, nil];
        addMenu.position = ccp(0, 170);
        
        // ajoute le menu
        [self addChild:addMenu];
        
	}
	return self;
}

-(void)initParticles{
    _pFireParticle1=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
    
    _pFireParticle2=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
    
    _pFireParticle3=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
    
    _pFireParticle4=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
    
    _pFireParticle5=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
    
    _pFireParticle6=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
}

-(void)initParticlesPosition{
    _pFireParticle1.position=ccp(-52,178);
    
    _pFireParticle2.position=ccp(-52,591);
    
    _pFireParticle3.position=ccp(-52,1064);
    
    _pFireParticle4.position=ccp(820,178);
    
    _pFireParticle5.position=ccp(820,591);
    
    _pFireParticle6.position=ccp(820,1064);
}


-(void)addFireParticle:(id)i_boutonClic
{
    [self initParticlesPosition];
    for(int i = 0; i < _aFireParticles.count; i++){
        CCParticleSystem* particle = [_aFireParticles objectAtIndex:i];
        [self addChild:particle];
        [self moveParticle:particle withIndex:i];
    }
    
    
}

-(void)moveParticle:(CCParticleSystem*)particle withIndex:(int)index{
    CGPoint target;
    switch (index) {
        case 0:
            target = ccp(820, [self randFloat:400 :1064]);
            break;
        case 1:
            target = ccp(820, [self randFloat:178 :1064]);
            break;
        case 2:
            target = ccp(820, [self randFloat:178 :782]);
            break;
        case 3:
            target = ccp(-52, [self randFloat:400 :1064]);
            break;
        case 4:
            target = ccp(-52, [self randFloat:178 :1064]);
            break;
        case 5:
            target = ccp(-52, [self randFloat:178 :782]);
            break;
            
        default:
            break;
    }
    ccTime moveDuration = ccpDistance(self.position, target) / 80;
    
    id randomMoveAction = [CCMoveTo actionWithDuration:moveDuration position:target];
    [particle runAction:randomMoveAction];
}

-(float) randFloat:(float)min :(float)max{
    float x = min + ((float)arc4random() / ARC4RANDOM_MAX) * (max - min);
    return x;
}

@end
