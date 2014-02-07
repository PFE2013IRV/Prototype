//
//  FireAttackLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "FireAttackLayer.h"
#import "GlobalConfig.h"


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
@synthesize _pCurrentGameData;
@synthesize _pCurrentGodData;
@synthesize canLaunchOtherFireBalls;
@synthesize nbBallTouch;

-(id) init
{
	if( (self=[super init]) )
    {
        //init particles
        [self initParticles];
        [self setTouchEnabled:true];
        
        canLaunchOtherFireBalls = YES;
        _speed = 160;
        
        // Bouton add fire attack
        CCMenuItemImage *addParticleFireButton = [CCMenuItemImage itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton.png" target:self selector:@selector(addFireParticle)];
        addParticleFireButton.position = ccp(30, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleFireButton, nil];
        addMenu.position = ccp(0, 170);
        
        // ajoute le menu
        [self addChild:addMenu];
        
        _pCurrentGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
        
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


-(void)addFireParticle
{
    [self removeParticlesFromLayer];
    [self unschedule:@selector(moveParticle:)];
    [self initParticles];

    canLaunchOtherFireBalls = NO;
    nbBallTouch = 0;
    _duration = 0;
    [self initParticlesPosition];
    for(int i = 0; i < _aFireParticles.count; i++){
        ParticleFire* particle = [_aFireParticles objectAtIndex:i];
        [self addChild:particle];
    }
    [self schedule:@selector(moveParticle:) interval:0.2];
}

-(void) removeParticlesFromLayer
{
    for(int i = 0; i<_aFireParticles.count; i++)
    {
        ParticleFire* particle =[_aFireParticles objectAtIndex:i];
        if(particle.parent == self){
            [particle removeFromParent];
        }
    }
    canLaunchOtherFireBalls = YES;
}


-(void)moveParticle:(ccTime)delta{

    
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleParticle:)])
    {
        // Stop all action runing on particles before running others
        [_pFireParticle1 stopAllActions];
        [_pFireParticle2 stopAllActions];
        [_pFireParticle3 stopAllActions];
        [_pFireParticle4 stopAllActions];
        [_pFireParticle5 stopAllActions];
        [_pFireParticle6 stopAllActions];

        ccTime moveDuration1 = ccpDistance(_pFireParticle1.position, _pFireParticle1._target)/ _speed;
        ccTime moveDuration2 = ccpDistance(_pFireParticle2.position, _pFireParticle2._target)/ _speed;
        ccTime moveDuration3 = ccpDistance(_pFireParticle3.position, _pFireParticle3._target)/ _speed;
        ccTime moveDuration4 = ccpDistance(_pFireParticle4.position, _pFireParticle4._target)/ _speed;
        ccTime moveDuration5 = ccpDistance(_pFireParticle5.position, _pFireParticle5._target)/ _speed;
        ccTime moveDuration6 = ccpDistance(_pFireParticle6.position, _pFireParticle6._target)/ _speed;
        
        BOOL visibleBalls = false;
        
        for(int i = 0; i < _aFireParticles.count; i++)
        {
            ParticleFire* particle = [_aFireParticles objectAtIndex:i];
            
            if(!(particle.parent == nil))
            {
                visibleBalls = true;
            }
        }
        
        if (!visibleBalls)
        {
            [self unschedule:@selector(moveParticle:)];
            [self removeParticlesFromLayer];
            
            canLaunchOtherFireBalls = YES;
            
            if (_pCurrentGodData._isAngry)
            {
                [self addFireParticle];
            }
            NSLog(@"particles removed from layer");
        }
        else
        {
            // Init actions moveTo particles specific targer
            id actionMove1 = [CCMoveTo actionWithDuration:moveDuration1 position:_pFireParticle1._target];
            id actionMove2 = [CCMoveTo actionWithDuration:moveDuration2 position:_pFireParticle2._target];
            id actionMove3 = [CCMoveTo actionWithDuration:moveDuration3 position:_pFireParticle3._target];
            id actionMove4 = [CCMoveTo actionWithDuration:moveDuration4 position:_pFireParticle4._target];
            id actionMove5 = [CCMoveTo actionWithDuration:moveDuration5 position:_pFireParticle5._target];
            id actionMove6 = [CCMoveTo actionWithDuration:moveDuration6 position:_pFireParticle6._target];
            
            // Run the specific actions on each particle
            [self.delegate handleParticle:_pFireParticle1];
            [_pFireParticle1 runAction:actionMove1];
            
            [self.delegate handleParticle:_pFireParticle2];
            [_pFireParticle2 runAction:actionMove2];
            
            
            [self.delegate handleParticle:_pFireParticle3];
            [_pFireParticle3 runAction:actionMove3];
            
            [self.delegate handleParticle:_pFireParticle4];
            [_pFireParticle4 runAction:actionMove4];
            
            [self.delegate handleParticle:_pFireParticle5];
            [_pFireParticle5 runAction:actionMove5];
            
            [self.delegate handleParticle:_pFireParticle6];
            [_pFireParticle6 runAction:actionMove6];
            
            _duration += delta;
        }
    }
    
    // Duration is the total time of the move
    // If duration > 20 it means that particles are out of hud
    // So we unschedule the moves
    if(_duration > TIME_FIRE_ATTACK)
    {
        [self unschedule:@selector(moveParticle:)];
        [self removeParticlesFromLayer];
        NSLog(@"particles removed from layer");
    }
    
}

-(float) randFloat:(float)min :(float)max{
    float x = min + ((float)arc4random() / ARC4RANDOM_MAX) * (max - min);
    return x;
}

/** Register with more priority than CCMenu's but don't swallow touches. */
-(void) registerWithTouchDispatcher
{
#if COCOS2D_VERSION >= 0x00020000
    CCTouchDispatcher *dispatcher = [[CCDirector sharedDirector] touchDispatcher];
    int priority = kCCMenuHandlerPriority + 1;
#else
    CCTouchDispatcher *dispatcher = [CCTouchDispatcher sharedDispatcher];
    int priority = kCCMenuTouchPriority + 1;
#endif
    
    [dispatcher addTargetedDelegate:self priority: priority swallowsTouches:NO];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
{
    _pCurrentGodData = [_pCurrentGameData getCurrentGod];
    //on récupère la location du point pour cocos2D
    CGPoint location = [self convertTouchToNodeSpace: touch];

    //on teste si les coordonnées sont sur la boule de feu à détruire
    [self removeTouchedParticle:_aFireParticles :location];

    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{

}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{

}

-(void)removeTouchedParticle:(NSMutableArray*)particles : (CGPoint)location
{
    for(int i = 0; i<particles.count; i++)
    {
        ParticleFire* particle = [particles objectAtIndex:i];
        
        CGRect bbox = [particle boundingBox];
        bbox.size.height = 150;
        bbox.size.width = 150;
        bbox.origin.x -= 70;
        bbox.origin.y -= 70;
        
        
        NSLog(@"bbox position:%f,%f height:%f width:%f", bbox.origin.x, bbox.origin.y, bbox.size.height, bbox.size.width);
        if (CGRectContainsPoint(bbox, location))
        {
            NSLog(@"removeparticleeeeeee!!!!!");
            
            [particle removeFromParent];
            
            [_pCurrentGodData increaseRespect:GOD_RESPECT_INCREASE];
            nbBallTouch ++;
        }
    }
    
    if (nbBallTouch == 6)
    {
        canLaunchOtherFireBalls = YES;
        
        if (_pCurrentGodData._isAngry)
        {
            [self addFireParticle];
        }
    }
}

-(void)endFireBalls
{
    [self unschedule:@selector(moveParticle:)];
    [self removeParticlesFromLayer];
    NSLog(@"particles removed from layer");
    
    canLaunchOtherFireBalls = YES;
}

@end
