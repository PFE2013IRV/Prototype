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
#import "CloudsFrontBottom.h"
#import "SimpleAudioEngine.h"

@implementation ConstructionTowerLayer


@synthesize pPlanetLayer = _pPlanetLayer;
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
@synthesize isScrolling = _isScrolling;
@synthesize startingScroll = _startingScroll;
@synthesize possibleScrollSize = _possibleScrollSize;
@synthesize scrollPosition = _scrollPosition;
@synthesize isZoomingOut = _isZoomingOut;
@synthesize isZoomingIn = _isZoomingIn;
@synthesize scalingFactor = _scalingFactor;
@synthesize positionBeforeZoom = _positionBeforeZoom;
@synthesize zoomOutPosition = _zoomOutPosition;
@synthesize indexBlocTouchByFire = _indexBlocTouchByFire;
@synthesize pBubbleSprite = _pBubbleSprite;
@synthesize isFireGodAngry = _isFireGodAngry;


-(id) initWithTowerData:(TowerData*) i_pTowerData WinningHeight:(int)winHeight
{
    if (self = [super init])
    {
        
        _moveTowerRuntime = _towerRuntime = 0.0f;
        _scrollingHeight = SCROLLING_HEIGHT;
        _indexBlocTouchByFire = [[NSMutableIndexSet alloc] init];
        _pPlanetLayer = [PlanetLayer node];
        self._pTowerData = i_pTowerData;
        _blocNotPlace = false;
        _aFallingBloc = [[NSMutableArray alloc] init];
        _pMovingSprite = nil;
        _winningHeight = winHeight;
        _isFireGodAngry = NO;
        
        _currentHeightNoScroll = 220;
        _HeightTower = 220;
        _scrollPosition = 0;
        
        _centerWidthTower = [[CCDirector sharedDirector] winSize].width / 2;
        _towerMagnetization = CGRectMake(_centerWidthTower - 50, _HeightTower, 100, 50);
        
        [self setTouchEnabled:YES];
        _isTouch = false;
        _isScrolling = false;
        
        [self addChild:_pPlanetLayer];
        [self scheduleUpdate];
    }
    
    return self;
}

-(void)menuSendOneBloc:(BlocData*)blocSelected
{
    if (!_blocNotPlace && !_isFireGodAngry)
    {
        [self replaceTowerToTopWithoutScroll:false];
        
        _blocNotPlace = true;
        _pMovingBlocData = blocSelected;
        CCSprite *blocSprite = [BlocManager GetSpriteFromModel:blocSelected];
        _pBubbleSprite = [CCSprite spriteWithFile:@"Bubble.png"];
        [[SimpleAudioEngine sharedEngine] playEffect:@"2.mp3"];
        
        float dimensionForScale = 1.0f;
        
        if(blocSprite.boundingBox.size.height >= blocSprite.boundingBox.size.width)
            dimensionForScale = blocSprite.contentSize.height;
        else
            dimensionForScale = blocSprite.contentSize.width;
        
        if (dimensionForScale < 100) dimensionForScale = 100;
        
        float bubbleScale = dimensionForScale / _pBubbleSprite.contentSize.height;
        
        _pBubbleSprite.scale = bubbleScale;
        _pBubbleSprite.opacity = 170;
        
        blocSprite.scale = 0.5;
        blocSprite.position = CGPointMake(BUBBLE_POINT_X, BUBBLE_POINT_Y);
        _pBubbleSprite.position = CGPointMake(BUBBLE_POINT_X, BUBBLE_POINT_Y);
        
        [self addChild:blocSprite];
        [self addChild:_pBubbleSprite];
        _pMovingSprite = blocSprite;
        
        [self schedule:@selector(moveBubbleLikeAPro:)];
    }
}

-(void) setPossibleScrollHeight: (float) i_possibleScrollHeight
{
    _scrollingHeight = i_possibleScrollHeight;
    
}

-(void)replaceTowerToTopWithoutScroll : (bool) doItSlowly
{
    [self scrollTower:_scrollPosition withSlowMotion:doItSlowly];
    _scrollPosition = 0;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
{
    //on récupère la location du point pour cocos2D
    CGPoint location = [self convertTouchToNodeSpace: touch];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    if (_pMovingSprite != nil)
    {
        //on test si les coordonnées sont sur le bloc qui peut bouger
        if (CGRectContainsPoint([_pBubbleSprite boundingBox], location))
        {
            [self unschedule:@selector(moveBubbleLikeAPro:)];
            _isTouch = YES;
            [_pBubbleSprite removeFromParent];
            _pBubbleSprite = nil;
            _bubbleRuntime = 0.0f;
        }
    }
    
    if (_isFireGodAngry)
    {
        if((location.y <= screenSize.height - 140) && _currentHeightNoScroll > screenSize.height)
        {
            _possibleScrollSize = _currentHeightNoScroll - screenSize.height;
            _isScrolling = YES;
            _startingScroll = location.y;
        }
    }
    else
    {
        if(!_isTouch && (location.y <= screenSize.height - 140) && _currentHeightNoScroll > SCROLLING_HEIGHT && !_blocNotPlace)
        {
            _possibleScrollSize = _currentHeightNoScroll - SCROLLING_HEIGHT + (SCROLLING_HEIGHT - _HeightTower);
            _isScrolling = YES;
            _startingScroll = location.y;
        }
    }
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //récupère les coordonnées pour cocos2D
    CGPoint location = [self convertTouchToNodeSpace: touch];
    
    if(_isTouch)
    {
        _pMovingSprite.scale = 1.0;

        [self moveBlocInScreen:location];
        
        if (CGRectIntersectsRect(_towerMagnetization, [_pMovingSprite boundingBox]))
        {
            _pMovingSprite.scale = 1.5;
        }
    }
    
    if (_isScrolling)
    {
        int heightScroll = _startingScroll - location.y;
        int testScrollPosition = _scrollPosition - heightScroll * SCROLLING_SPEED_COEF;
        
        if(_isFireGodAngry)
        {
            if (testScrollPosition >= 0 && testScrollPosition <= _possibleScrollSize)
            {
                [self scrollTower: heightScroll * SCROLLING_SPEED_COEF withSlowMotion:false];
                _scrollPosition -= heightScroll * SCROLLING_SPEED_COEF;
            }
        }
        else
        {
            if (testScrollPosition >= 0 && testScrollPosition <= _possibleScrollSize)
            {
                [self scrollTower:heightScroll * SCROLLING_SPEED_COEF withSlowMotion:false];
                _scrollPosition -= heightScroll * SCROLLING_SPEED_COEF;
            }
        }
        
        _startingScroll = location.y;
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
    
    _isScrolling = NO;
}

-(void)destroyBlocWithGodAttack
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"GodFire.mp3"];
    
    if (_blocNotPlace)
    {
        _isTouch = NO;
        [self unschedule:@selector(moveBubbleLikeAPro:)];
        _bubbleRuntime = 0.0f;
        [_pBubbleSprite removeFromParent];
        _pBubbleSprite = nil;
        [self addToFallingBloc];
        _pMovingBlocData = nil;
    }
    _blocNotPlace = true;
    _isFireGodAngry = YES;
    
    if (_currentHeightNoScroll > _HeightTower)
    {
        [self scrollTowerNoMoveTo:-(_currentHeightNoScroll - _HeightTower - _scrollPosition)];
    }
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    int possibleScroll = _currentHeightNoScroll - screenSize.height;
    _scrollPosition = 0;
    
    if (possibleScroll > 0)
    {
        [self scrollTower:possibleScroll withSlowMotion:YES];
    }
}

-(void)addBlocToTower
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"3.mp3"];
    [self._aBlocsTowerSprite addObject:_pMovingSprite];
    [self._pTowerData._aBlocs addObject:_pMovingBlocData];
    
    _currentHeightNoScroll += _pMovingBlocData._scaledSize.height;
    _HeightTower += _pMovingBlocData._scaledSize.height;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(increaseGodRespect:)])
    {
        [self.delegate increaseGodRespect:_pMovingBlocData.respectEarnWithGod];
    }
    
    if (_currentHeightNoScroll > _winningHeight)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"C'EST VOUS LE PATRON" message:@"Vous avez réussi ce magnifique niveau de démo" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if (_HeightTower > _scrollingHeight)
        {
            [self movePlanet:_pMovingBlocData._scaledSize.height];
            
            [self moveAllBlocTower];
            _HeightTower -= _pMovingBlocData._scaledSize.height;
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

-(void)scrollTowerNoMoveTo:(int)scroll
{

    _pPlanetLayer.position = ccp(_pPlanetLayer.position.x, _pPlanetLayer.position.y - scroll);
    
    for (CCSprite* blocSprite in self._aBlocsTowerSprite)
    {
        blocSprite.position = ccp(blocSprite.position.x,blocSprite.position.y - scroll);
    }
}

-(void)scrollTower:(int)scroll withSlowMotion: (bool) doItSlowly
{
    [self movePlanet:scroll];
    
    float moveDuration = 0.2;
    if(doItSlowly)
        moveDuration = 1.5;
    
    for (CCSprite* blocSprite in self._aBlocsTowerSprite)
    {
        CCAction* pMoveTo = [CCMoveTo actionWithDuration:moveDuration position:ccp(blocSprite.position.x,blocSprite.position.y - scroll)];
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
    if (_isTouch)
    {
        _blocNotPlace = false;
        _isTouch = NO;
        
        [self addToFallingBloc];
        
        _pMovingBlocData = nil;
    }
    
    _isScrolling = NO;
}


-(void) zoomOutTower:(ccTime)delta
{

    [self stopAllActions];
    
    if(_currentHeightNoScroll < _scrollingHeight) return;
    
    _scalingFactor = 700.0f / (_currentHeightNoScroll + _pPlanetLayer.pPlanetSprite.boundingBox.size.height);
    
    if(_scalingFactor > 1) _scalingFactor = 0.8f;

    _isZoomingOut = YES;
    _positionBeforeZoom = self.position;
        
    _zoomOutPosition = _positionBeforeZoom;
    
    id zoomIn = [CCScaleTo actionWithDuration:1.5f scale:_scalingFactor];
    id calculatePosition = [CCCallBlock actionWithBlock:^{
        
        _zoomOutPosition = self.position;
        _zoomOutPosition.y += _currentHeightNoScroll*_scalingFactor/3;

    }];
    
    
    id addCloudsToSelf = [CCCallBlock actionWithBlock:^{
        
        CloudsFrontBottom* pClouds = [[CloudsFrontBottom alloc] init];
        [[self parent] addChild:pClouds];
        CGPoint cloudsPos = pClouds.position;
        cloudsPos.y -= 250;
        pClouds.position = cloudsPos;

        [self.pPlanetLayer removeClouds];
        
        CCAction* moveCloudsUpAgain = [CCMoveTo actionWithDuration:1 position:ccp(cloudsPos.x,cloudsPos.y+250)];
        
        [pClouds runAction:moveCloudsUpAgain];
        
    }];

    
    id reset = [CCCallBlock actionWithBlock:^{
        _isZoomingOut = NO;
    }];
    id sequence = [CCSequence actions:addCloudsToSelf,calculatePosition,zoomIn,[CCDelayTime actionWithDuration:1.5], reset, nil];
    
    [self runAction:sequence];
    
}

-(void) calculatePositionAfterZoom:(id) sender
{
    _zoomOutPosition.y = _positionBeforeZoom.y + _currentHeightNoScroll*_scalingFactor - (_pPlanetLayer.pPlanetSprite.contentSize.height)*_scalingFactor + _currentHeightNoScroll*_scalingFactor/2;
    _zoomOutPosition = self.position;
    _zoomOutPosition.y += _currentHeightNoScroll*_scalingFactor/2;
    
}

-(void) zoomInTower:(ccTime)delta
{
    [self stopAllActions];

    _isZoomingIn = YES;
        
    id zoomOut = [CCScaleTo actionWithDuration:0.5f scale:1];
    id moveTo = [CCMoveTo actionWithDuration:0.5f position:_positionBeforeZoom];

    id reset = [CCCallBlock actionWithBlock:^{
        CCLOG(@"zoom in/out complete");
            _isZoomingIn = NO;
    }];
    id sequence = [CCSequence actions:zoomOut,reset,moveTo,nil];
    [self runAction:sequence];
}

-(void)movePlanet:(int)height
{
    CCAction* pMoveTo = [CCMoveTo actionWithDuration:0.2 position:ccp(_pPlanetLayer.position.x, _pPlanetLayer.position.y - height)];
    [_pPlanetLayer runAction:pMoveTo];
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

-(void)handleParticle:(ParticleFire *)particle
{
    for(int i = 0; i < self._aBlocsTowerSprite.count; i++)
    {
        CCSprite *blocSprite = [self._aBlocsTowerSprite objectAtIndex:i];
        
        if ((CGRectContainsPoint([blocSprite boundingBox], particle.position)))
        {
            [particle removeFromParent];
            BlocData *blocData = [self._pTowerData._aBlocs objectAtIndex:i];
            
            if (![_indexBlocTouchByFire containsIndex:i] && blocData._eBlocMaterial == MAT_WOOD)
            {
                [_indexBlocTouchByFire addIndex:i];
                
                if (!SIMULATOR_MODE)
                {
                    CCParticleSystemQuad* burnParticle =[[CCParticleSystemQuad alloc] initWithFile:@"burningBlocParticle.plist"];
                    [blocSprite addChild:burnParticle];
                    burnParticle.life = (burnParticle.life * blocSprite.boundingBox.size.height/100) - 0.2;
                    burnParticle.position = ccp([blocSprite boundingBox].size.width / 2 ,0.0);
                    burnParticle.posVar = ccp([blocSprite boundingBox].size.width/4,0.0);
                    NSLog(@"taille bloc: %f",blocSprite.boundingBox.size.height);
                    
                    CCParticleSystemQuad* smokeParticle =[[CCParticleSystemQuad alloc] initWithFile:@"smokeBlocParticle.plist"];
                    [blocSprite addChild:smokeParticle];
                    smokeParticle.position = ccp([blocSprite boundingBox].size.width / 2 ,0.0);
                    smokeParticle.posVar = ccp([blocSprite boundingBox].size.width/4,0.0);
                    
                    [blocSprite reorderChild:smokeParticle z:-1];
                    [blocSprite reorderChild:burnParticle z:1];
                }
            }
        }
    }
}


-(void)removeBlocAtIndexes:(NSIndexSet*) indexes
{
    __block int totalHeight = 0;
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop)
    {
        totalHeight += [self burnOneBlocAtIndex:idx];
    }];
    
    [self._aBlocsTowerSprite removeObjectsAtIndexes:indexes];
    [self._pTowerData._aBlocs removeObjectsAtIndexes:indexes];
    [_indexBlocTouchByFire removeAllIndexes];
    
    _HeightTower = [self calculNewHeightTowerAfterChange];
    _towerMagnetization = CGRectMake(_centerWidthTower - 50, _HeightTower, 100, 50);
    
    if([self._pTowerData._aBlocs count] > 0)
    {
        BlocData *firstBloc = [self._pTowerData._aBlocs objectAtIndex:0];
        CCSprite *firstSprite = [self._aBlocsTowerSprite objectAtIndex:0];
        
        int heightMaxToMoveUp = 220 + firstBloc._scaledSize.height / 2 - firstSprite.position.y;
        [self scrollTowerNoMoveTo: - heightMaxToMoveUp];
        
        _scrollPosition = _currentHeightNoScroll - SCROLLING_HEIGHT + (SCROLLING_HEIGHT - _HeightTower);
        if (_currentHeightNoScroll > SCROLLING_HEIGHT)
        {
            [self replaceTowerToTopWithoutScroll:true];
        }
    }
    else
    {
        [_pPlanetLayer removeFromParent];
        _pPlanetLayer = [PlanetLayer node];
        [self addChild:_pPlanetLayer];
    }
    
    _scrollPosition = 0;
}


-(int)burnOneBlocAtIndex:(int)index
{
    BlocData *blocDataToRemove = [self._pTowerData._aBlocs objectAtIndex:index];
    
    CCSprite *blocSpriteToRemove = [self._aBlocsTowerSprite objectAtIndex:index];
    
    int height = blocDataToRemove._scaledSize.height;
    _currentHeightNoScroll -= height;
    
    for (int i = index; i < [self._aBlocsTowerSprite count]; i++)
    {
        CCSprite *spriteToMove = [self._aBlocsTowerSprite objectAtIndex:i];
        spriteToMove.position = ccp(spriteToMove.position.x,spriteToMove.position.y - height);
    }
    
    [blocSpriteToRemove removeFromParentAndCleanup:YES];
    
    return height;
}

-(int)calculNewHeightTowerAfterChange
{
    int newHeightTower = 220;
    
    for (BlocData *blocInTower in self._pTowerData._aBlocs)
    {
        newHeightTower += blocInTower._scaledSize.height;
        
        if (newHeightTower > _scrollingHeight)
        {
            newHeightTower -= blocInTower._scaledSize.height;
        }
    }
    
    return newHeightTower;
}

-(void) update:(ccTime)dt
{
    // mise à jour de la position du layer en cas de dezoom
    if(_isZoomingOut)
    {
        _moveTowerRuntime += (_zoomOutPosition.y - self.position.y);
        
    }
    
    // Le dieu du vent attaque ! La tour va trembler (cas spécial)
    if(self._pCurrentGameData._pWindGodData._godIsAttacking == YES)
    {
        _towerRuntime += dt * 30.0f;
        
        self.position = ccp((cosf(_towerRuntime))*10.0f,  _moveTowerRuntime*0.5 + (sinf(_towerRuntime) * 10.0f));
        
    }
    // Choses à faire quand le dieu du vent n'attaque pas
    else
    {
        // Dans le cas du dezoom, on recentre la tour
        if(_isZoomingOut)
        {
            self.position = ccp(_zoomOutPosition.x,  _moveTowerRuntime);
        }
    }
}


-(void)moveBubbleLikeAPro:(ccTime)dt
{
    _bubbleRuntime += dt * 5.0f;
    float moveHorizontalCoeff = 2 * _bubbleRuntime;
    
    _pBubbleSprite.position = ccp(moveHorizontalCoeff + BUBBLE_POINT_X + (sinf(_bubbleRuntime)), -moveHorizontalCoeff + BUBBLE_POINT_Y + (sinf(_bubbleRuntime)));
    _pMovingSprite.position = _pBubbleSprite.position;
}

@end
