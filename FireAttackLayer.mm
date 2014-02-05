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
@synthesize _duration;
@synthesize _speed;

-(id) init
{
	if( (self=[super init]) )
    {
        //init particles
        [self initParticles];
        
        _speed = 6;
        
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
    _pFireParticle1=[[ParticleFire alloc] initWithFile:@"fireParticle.plist"];
    _pFireParticle1._target = ccp(820, [self randFloat:400 :1064]);
    
    _pFireParticle2=[[ParticleFire alloc] initWithFile:@"fireParticle.plist"];
    _pFireParticle2._target = ccp(820, [self randFloat:178 :1064]);
    
    _pFireParticle3=[[ParticleFire alloc] initWithFile:@"fireParticle.plist"];
    _pFireParticle3._target = ccp(820, [self randFloat:178 :782]);
    
    _pFireParticle4=[[ParticleFire alloc] initWithFile:@"fireParticle.plist"];
    _pFireParticle4._target = ccp(-52, [self randFloat:400 :1064]);
    
    _pFireParticle5=[[ParticleFire alloc] initWithFile:@"fireParticle.plist"];
    _pFireParticle5._target = ccp(-52, [self randFloat:178 :1064]);
    
    _pFireParticle6=[[ParticleFire alloc] initWithFile:@"fireParticle.plist"];
    _pFireParticle6._target = ccp(-52, [self randFloat:178 :782]);
    //init array
    _aFireParticles=[[NSMutableArray alloc]initWithObjects:_pFireParticle1,_pFireParticle2, _pFireParticle3, _pFireParticle4, _pFireParticle5, _pFireParticle6, nil];
}

-(void)initParticlesPosition{
    _pFireParticle1._initialPosition=ccp(-52,178);
    _pFireParticle1.position=_pFireParticle1._initialPosition;
    _pFireParticle1._pente = (_pFireParticle1._target.y - _pFireParticle1.position.y) / (_pFireParticle1._target.x - _pFireParticle1.position.x);
    _pFireParticle1._coeffB = _pFireParticle1.position.y - _pFireParticle1._pente * _pFireParticle1.position.x;
    
    _pFireParticle2._initialPosition=ccp(-52,591);
    _pFireParticle2.position=_pFireParticle2._initialPosition;
    _pFireParticle2._pente = (_pFireParticle2._target.y - _pFireParticle2.position.y) / (_pFireParticle2._target.x - _pFireParticle2.position.x);
    _pFireParticle2._coeffB = _pFireParticle2.position.y - _pFireParticle2._pente * _pFireParticle2.position.x;
    
    _pFireParticle3._initialPosition=ccp(-52,1064);
    _pFireParticle3.position=_pFireParticle3._initialPosition;
    _pFireParticle3._pente = (_pFireParticle3._target.y - _pFireParticle3.position.y) / (_pFireParticle3._target.x - _pFireParticle3.position.x);
    _pFireParticle3._coeffB = _pFireParticle3.position.y - _pFireParticle3._pente * _pFireParticle3.position.x;
    
    _pFireParticle4._initialPosition=ccp(820,178);
    _pFireParticle4.position=_pFireParticle4._initialPosition;
    _pFireParticle4._pente = (_pFireParticle4._target.y - _pFireParticle4.position.y) / (_pFireParticle4._target.x - _pFireParticle4.position.x);
    _pFireParticle4._coeffB = _pFireParticle4.position.y - _pFireParticle4._pente * _pFireParticle4.position.x;
    
    _pFireParticle5._initialPosition=ccp(820,591);
    _pFireParticle5.position=_pFireParticle5._initialPosition;
    _pFireParticle5._pente = (_pFireParticle5._target.y - _pFireParticle5.position.y) / (_pFireParticle5._target.x - _pFireParticle5.position.x);
    _pFireParticle5._coeffB = _pFireParticle5.position.y - _pFireParticle5._pente * _pFireParticle5.position.x;
    
    _pFireParticle6._initialPosition=ccp(820,1064);
    _pFireParticle6.position=_pFireParticle6._initialPosition;
    _pFireParticle6._pente = (_pFireParticle6._target.y - _pFireParticle6.position.y) / (_pFireParticle6._target.x - _pFireParticle6.position.x);
    _pFireParticle6._coeffB = _pFireParticle6.position.y - _pFireParticle6._pente * _pFireParticle6.position.x;
}


-(void)addFireParticle:(id)i_boutonClic
{
    [self removeParticlesFromLayer];
    [self unschedule:@selector(moveParticle:)];
    [self initParticles];

    _duration = 0;
    [self initParticlesPosition];
    for(int i = 0; i < _aFireParticles.count; i++){
        ParticleFire* particle = [_aFireParticles objectAtIndex:i];
        [self addChild:particle];
    }
    [self schedule:@selector(moveParticle:) interval:0.05];
}

-(void) removeParticlesFromLayer{
    for(int i = 0; i<_aFireParticles.count; i++)
    {
        ParticleFire* particle =[_aFireParticles objectAtIndex:i];
        if(particle.parent == self){
            [particle removeFromParent];
            //[particle dealloc];
        }
    }
}


-(void)moveParticle:(ccTime)delta{

    //ccTime moveDuration = ccpDistance(particle.position, target) / 80;
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleParticle:)])
    {
        [self.delegate getParticles:_aFireParticles];

        [self.delegate handleParticle:_pFireParticle1];
        _pFireParticle1.position = ccp(_pFireParticle1.position.x + _speed*2, (int)(_pFireParticle1._pente*(_pFireParticle1.position.x + _speed*2) + _pFireParticle1._coeffB));
        
        [self.delegate handleParticle:_pFireParticle2];
        _pFireParticle2.position = ccp(_pFireParticle2.position.x + _speed, (int)(_pFireParticle2._pente*(_pFireParticle2.position.x + _speed) + _pFireParticle2._coeffB));
        
        [self.delegate handleParticle:_pFireParticle3];
        _pFireParticle3.position = ccp(_pFireParticle3.position.x + _speed*3, (int)(_pFireParticle3._pente*(_pFireParticle3.position.x + _speed*3) + _pFireParticle3._coeffB));
    
        [self.delegate handleParticle:_pFireParticle4];
        _pFireParticle4.position = ccp(_pFireParticle4.position.x - _speed*2, (int)(_pFireParticle4._pente*(_pFireParticle4.position.x - _speed*2) + _pFireParticle4._coeffB));
        
        [self.delegate handleParticle:_pFireParticle4];
        _pFireParticle5.position = ccp(_pFireParticle5.position.x - _speed, (int)(_pFireParticle5._pente*(_pFireParticle5.position.x - _speed) + _pFireParticle5._coeffB));
        
        [self.delegate handleParticle:_pFireParticle6];
        _pFireParticle6.position = ccp(_pFireParticle6.position.x - _speed*3, (int)(_pFireParticle6._pente*(_pFireParticle6.position.x - _speed*3) + _pFireParticle6._coeffB));
        
        [self.delegate setParticles:_aFireParticles];

        _duration += delta;
    
    }
    
    if(_duration > 20){
        [self unschedule:@selector(moveParticle:)];
        [self removeParticlesFromLayer];
        NSLog(@"particles removed from layer");
    }
    
}

-(float) randFloat:(float)min :(float)max{
    float x = min + ((float)arc4random() / ARC4RANDOM_MAX) * (max - min);
    return x;
}

@end
