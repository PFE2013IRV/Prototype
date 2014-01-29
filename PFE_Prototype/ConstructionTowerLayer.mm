//
//  ConstructionTowerLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 16/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "ConstructionTowerLayer.h"
#import "BlocManager.h"
#import "GlobalConfig.h"

@implementation ConstructionTowerLayer

@synthesize pMovingBlocData = _pMovingBlocData;
@synthesize blocNotPlace = _blocNotPlace;
@synthesize isTouch = _isTouch;

-(id) initWithTowerData:(TowerData*) i_pTowerData
{
    if (self = [super init])
    {
        self._pTowerData = i_pTowerData;
        _blocNotPlace = false;
        
        [self setTouchEnabled:YES];
        _isTouch = false;
    }
    
    return self;
}

-(void)menuSendOneBloc:(BlocData*)blocSelected
{
    if (!_blocNotPlace)
    {
        _blocNotPlace = true;
        _pMovingBlocData = blocSelected;
        CCSprite *blocSprite = [BlocManager GetSpriteFromModel:blocSelected];
        blocSprite.position = CGPointMake(BUBBLE_POINT_X, BUBBLE_POINT_Y);
        [self addChild:blocSprite];
        [self._aBlocsTowerSprite addObject:blocSprite];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sélection impossible" message:@"Vous êtes déjà entrain de placer un bloc sur la tour" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
{
    //on récupère la location du point pour cocos2D
    CGPoint location = [self convertTouchToNodeSpace: touch];
    
    if ([self._aBlocsTowerSprite count] > 0)
    {
        //on test si les coordonnées sont sur le bloc qui peut bouger
        if (CGRectContainsPoint([[self._aBlocsTowerSprite objectAtIndex:self._aBlocsTowerSprite.count - 1] boundingBox], location))
        {
            _isTouch = YES;
        }
    }
    
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(_isTouch)
    {
        //récupère les coordonnées pour cocos2D
        CGPoint location = [self convertTouchToNodeSpace: touch];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite *bloc = [self._aBlocsTowerSprite objectAtIndex:self._aBlocsTowerSprite.count - 1];
        
        int minHeight = 220 + [bloc boundingBox].size.height /2;
        //on bouge le sprite du cube
        if (location.x < screenSize.width && location.x > 0 && location.y > minHeight && location.y < screenSize.height)
        {
            bloc.position = ccp(location.x, location.y);
        }
        
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_isTouch)
    {
        [self._pTowerData._aBlocs addObject:_pMovingBlocData];
        _blocNotPlace = false;
        _isTouch = NO;
    }
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

/** Register with more priority than CCMenu's but don't swallow touches. */
-(void) registerWithTouchDispatcher
{
#if COCOS2D_VERSION >= 0x00020000
    CCTouchDispatcher *dispatcher = [[CCDirector sharedDirector] touchDispatcher];
    int priority = kCCMenuHandlerPriority - 1;
#else
    CCTouchDispatcher *dispatcher = [CCTouchDispatcher sharedDispatcher];
    int priority = kCCMenuTouchPriority - 1;
#endif
    
    [dispatcher addTargetedDelegate:self priority: priority swallowsTouches:NO];
}


@end
