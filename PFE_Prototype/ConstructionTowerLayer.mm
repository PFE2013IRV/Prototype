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
@synthesize HeightTower = _HeightTower;
@synthesize centerWidthTower = _centerWidthTower;
@synthesize towerMagnetization = _towerMagnetization;
@synthesize aFallingBloc = _aFallingBloc;
@synthesize pMovingSprite = _pMovingSprite;
@synthesize winningHeight = _winningHeight;
@synthesize currentHeightNoScroll = _currentHeightNoScroll;
@synthesize _currentGodData;
@synthesize _currentGameData;
@synthesize _aParticlesArray;

-(id) initWithTowerData:(TowerData*) i_pTowerData WinningHeight:(int)winHeight
{
    if (self = [super init])
    {
        self._pTowerData = i_pTowerData;
        _blocNotPlace = false;
        _aFallingBloc = [[NSMutableArray alloc] init];
        _pMovingSprite = nil;
        _winningHeight = winHeight;
        
        _currentHeightNoScroll = 0;
        _HeightTower = 220;
        _centerWidthTower = [[CCDirector sharedDirector] winSize].width / 2;
        _towerMagnetization = CGRectMake(_centerWidthTower - 50, _HeightTower, 100, 50);
        
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
        _pMovingSprite = blocSprite;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sélection impossible" message:@"Vous êtes déjà entrain de placer un bloc sur la tour" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
{
    _currentGameData = [[LevelVisitor GetLevelVisitor] _pCurrentGameData];
    _currentGodData = [_currentGameData getCurrentGod];
    //on récupère la location du point pour cocos2D
    CGPoint location = [self convertTouchToNodeSpace: touch];
    
    if(_currentGodData._eGodType == 1){
        if (_currentGodData._isAngry) {
            //on teste si les coordonnées sont sur la boule de feu à détruire
            [self removeTouchedParticle:_aParticlesArray :location];
        }
    }
    if (_pMovingSprite != nil)
    {
        //on test si les coordonnées sont sur le bloc qui peut bouger
        if (CGRectContainsPoint([_pMovingSprite boundingBox], location))
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
        _pMovingSprite.scale = 1.0;
        
        //récupère les coordonnées pour cocos2D
        CGPoint location = [self convertTouchToNodeSpace: touch];

        [self moveBlocInScreen:location];
        
        if (CGRectIntersectsRect(_towerMagnetization, [_pMovingSprite boundingBox]))
        {
            _pMovingSprite.scale = 1.2;
        }
    }
}


-(void)placeBlocToTower
{
    int centerWidthBloc;
    int centerHeighBloc = _pMovingBlocData._scaledSize.height / 2;
    
    if (_pMovingBlocData._hasSmallerBase)
    {
        centerWidthBloc = _pMovingBlocData._specialBaseOffset / 2;
    }
    else
    {
        centerWidthBloc = _pMovingBlocData._scaledSize.width / 2 - _pMovingBlocData._gravityCenter.x;
    }
    
    centerWidthBloc += _centerWidthTower;
    centerHeighBloc += _HeightTower;
    
    _pMovingSprite.scale = 1.0;
    CCAction* pMoveTo = [CCMoveTo actionWithDuration:0.2 position:ccp(centerWidthBloc, centerHeighBloc)];
    [_pMovingSprite runAction:pMoveTo];
}


-(void)moveBlocInScreen:(CGPoint)location
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    int bordurSize = 9;
    int minHeight = 220 + [_pMovingSprite boundingBox].size.height /2;
    int maxHeight = screenSize.height - [_pMovingSprite boundingBox].size.height /2 - bordurSize;
    int minWidth = [_pMovingSprite boundingBox].size.width /2 + bordurSize;
    int maxWidth = screenSize.width - [_pMovingSprite boundingBox].size.width /2 - bordurSize;
    
    //on bouge le sprite du cube en testant si il ne dépasse pas les limits de déplacement autorisé.
    if (location.x < maxWidth && location.x > minWidth && location.y > minHeight && location.y < maxHeight)
    {
        _pMovingSprite.position = ccp(location.x, location.y);
    }
    else if (location.x < maxWidth && location.x > minWidth && location.y < minHeight)
    {
        _pMovingSprite.position = ccp(location.x, minHeight);
    }
    else if (location.x < maxWidth && location.x > minWidth && location.y > maxHeight)
    {
        _pMovingSprite.position = ccp(location.x, maxHeight);
    }
    else if (location.y > minHeight && location.y < maxHeight && location.x < minWidth)
    {
        _pMovingSprite.position = ccp(minWidth, location.y);
    }
    else if (location.y > minHeight && location.y < maxHeight && location.x > maxWidth)
    {
        _pMovingSprite.position = ccp(maxWidth, location.y);
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_isTouch)
    {
        [self._pTowerData._aBlocs addObject:_pMovingBlocData];
        _blocNotPlace = false;
        _isTouch = NO;
        
        if (CGRectIntersectsRect(_towerMagnetization, [_pMovingSprite boundingBox]))
        {
            [self placeBlocToTower];
            [self addBlocToTower];
        }
        else
        {
            [self addToFallingBloc];
        }
        
        
        _pMovingBlocData = nil;
    }
}

-(void)addBlocToTower
{
    [self._aBlocsTowerSprite addObject:_pMovingSprite];
    [self._pTowerData._aBlocs addObject:_pMovingBlocData];
    
    _currentHeightNoScroll += _pMovingBlocData._scaledSize.height;
    
    if (_currentHeightNoScroll > _winningHeight)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"C'EST VOUS LE PATRON" message:@"Vous avez réussi ce magnifique niveau de démo" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if (_HeightTower > SCROLLING_HEIGHT)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(movePlanet:)])
            {
                [self.delegate movePlanet:_pMovingBlocData._scaledSize.height];
            }
            
            [self moveAllBlocTower];
        }
        else
        {
            _HeightTower += _pMovingBlocData._scaledSize.height;
        }
        
        _towerMagnetization = CGRectMake(_centerWidthTower - 50, _HeightTower, 100, 50);
    }
    
    _pMovingSprite = nil;
}

-(void)moveAllBlocTower
{
    int height = _pMovingBlocData._scaledSize.height;
    
    for (CCSprite* blocSprite in self._aBlocsTowerSprite)
    {
        CCAction* pMoveTo = [CCMoveTo actionWithDuration:0.2 position:ccp(blocSprite.position.x,blocSprite.position.y - height)];
        [blocSprite runAction:pMoveTo];
    }
}


-(void)addToFallingBloc
{
    _pMovingSprite.scale = 0.8;
    _pMovingSprite.opacity = 100;
    [_aFallingBloc addObject:_pMovingBlocData];
    CCSequence* pFallAndRemove = [CCSequence actions:
                         [CCCallFunc actionWithTarget:self selector:@selector(movingSpriteFalling:)],
                         [CCDelayTime actionWithDuration: 0.8f],
                         [CCCallFunc actionWithTarget:self selector:@selector(removeMovingSpriteFromParent:)],
                         nil];
    
    
    [self runAction:pFallAndRemove];
}

- (void) movingSpriteFalling : (id) sender
{
    CCSequence* pFall = [CCSequence actions:
                [CCMoveTo actionWithDuration:0.8f position:ccp(_pMovingSprite.position.x, -10)],
                nil];
    
    [_pMovingSprite runAction:pFall];
}

- (void) removeMovingSpriteFromParent : (id) sender
{
    [_pMovingSprite removeFromParent];
    _pMovingSprite = nil;
}


- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

/** Register with more priority than CCMenu's but don't swallow touches. */
-(void) registerWithTouchDispatcher
{
#if COCOS2D_VERSION >= 0x00020000
    CCTouchDispatcher *dispatcher = [[CCDirector sharedDirector] touchDispatcher];
    int priority = kCCMenuHandlerPriority + 3;
#else
    CCTouchDispatcher *dispatcher = [CCTouchDispatcher sharedDispatcher];
    int priority = kCCMenuTouchPriority + 3;
#endif
    
    [dispatcher addTargetedDelegate:self priority: priority swallowsTouches:NO];
}

-(void)getParticles:(NSMutableArray*) particles{
    self._aParticlesArray = particles;
    NSLog(@"maj particles cote construction");
}

-(void)setParticles:(NSMutableArray*) particles{
    particles = self._aParticlesArray;
    NSLog(@"maj particles cote layerFire");
}

-(void)handleParticle:(ParticleFire *)particle{
    for(int i = 0; i<self._aBlocsTowerSprite.count; i++){
        CCSprite *blocSprite = [self._aBlocsTowerSprite
                    objectAtIndex:i];
        if ((CGRectContainsPoint([blocSprite boundingBox], particle.position))) {
            [self._aBlocsTowerSprite removeObject:blocSprite];
            [blocSprite removeFromParent];
            [particle removeFromParent];
            [blocSprite dealloc];
            NSLog(@"bloc touché !!!");
        }
    }
}

-(void)removeTouchedParticle:(NSMutableArray*)particles : (CGPoint)location{
    ParticleFire* particle1 = [particles objectAtIndex:0];
    NSLog(@"position particle1:%f,%f", particle1.position.x, particle1.position.y);
    NSLog(@"position location:%f,%f", location.x, location.y);
    //CGRect bbox = [particle1 boundingBox];
   // NSLog(@"bbox position:%f,%f height:%f width:%f", bbox.origin.x, bbox.origin.y, bbox.size.height, bbox.size.width);
    for(int i = 0; i<particles.count; i++)
    {
        ParticleFire* particle = [particles objectAtIndex:i];
        CGRect bbox = [particle boundingBox];
        bbox.size.height = 80;
        bbox.size.width = 80;
        NSLog(@"bbox position:%f,%f height:%f width:%f", bbox.origin.x, bbox.origin.y, bbox.size.height, bbox.size.width);
        if (CGRectContainsPoint(bbox, location)){
            NSLog(@"removeparticleeeeeee!!!!!");
            

            [particle removeFromParent];
        }
    }
}


@end
