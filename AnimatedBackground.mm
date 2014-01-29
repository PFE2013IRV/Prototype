//
//  AnimatedBackground.m
//
//  This layer contains the animated background (with an other planet and an other
//  tower being built)
//

#import "AnimatedBackground.h"
#import "BlocManager.h"
#import "BlocBagData.h"


@implementation AnimatedBackground

@synthesize _aBlocs;
@synthesize _aMoveTo;
@synthesize _aRotate;
@synthesize _pPlanet;

- (id) initWithPlanetPosition: (CGPoint) i_planetPosition withScale: (float) i_scale withBeginDelay: (float) i_beginDelay withPlanetType: (int) i_planetType
{
    if((self=[super init]))
    {
        
        /////////////////////////////////////////
        // Création des sprites
        
        // Faire une image pour small planet
        if(i_planetType == 1)
            _pPlanet = [CCSprite spriteWithFile:@"microplanet1.png"];
        else if (i_planetType == 2)
            _pPlanet = [CCSprite spriteWithFile:@"microplanet2.png"];
        [_pPlanet setScale:i_scale];
        _pPlanet.position = ccp(i_planetPosition.x,i_planetPosition.y);
        
        [self addChild:_pPlanet];
        
        _aBlocs = [[NSMutableArray alloc] init];
        
        
        for(int i = 0; i < 8 ; i++)
        {
           /* int index;
            
            if(i <= 3)
            {
                index = i;
            }
            else
                index = i-4;*/
            
            NSString* sPrefix = @"BkgBloc_";
            NSString* sName = [sPrefix stringByAppendingString:[NSString stringWithFormat:@"%d.png",i]];
            
            CCSprite* pSprite = [[CCSprite spriteWithFile:sName] autorelease];
            
            [pSprite setScale:i_scale];
            pSprite.anchorPoint = ccp(0.5f, 0.0f);
            pSprite.position = ccp(i_planetPosition.x,1100);
            [_aBlocs addObject:pSprite];
            
            [self addChild:pSprite];
            
        }
        
        /////////////////////////////////////////
        // Paramétrage des moveTo
        
        _aMoveTo = [[NSMutableArray alloc] init];
        
        // Le positionnement des blocs doit évoluer à chaque tour
        
        float planetOffset = [_pPlanet boundingBox].size.height / 3;
        float blocHeights = 0;
        
        for(int i = 0 ; i < _aBlocs.count ; i++)
        {
            CGPoint positionBloc = _pPlanet.position;
            positionBloc.y += planetOffset + blocHeights;
            
            blocHeights+= [[_aBlocs objectAtIndex:i] boundingBox].size.height;
            CCAction* pAction = [CCMoveTo actionWithDuration:3 position:positionBloc];
            [_aMoveTo addObject:pAction];
            
        }
        
        /////////////////////////////////////////
        // Paramétrage des rotations
        
        _aRotate = [[NSMutableArray alloc] init];
        
        [_aRotate addObject:[CCRotateBy actionWithDuration:2 angle: 15]];
        [_aRotate addObject:[CCRotateBy actionWithDuration:2 angle: -15]];
        [_aRotate addObject:[CCRotateBy actionWithDuration:2 angle: 8]];
        [_aRotate addObject:[CCRotateBy actionWithDuration:3 angle: -8]];
        [_aRotate addObject:[CCRotateBy actionWithDuration:0.5 angle: 10]];
        [_aRotate addObject:[CCRotateBy actionWithDuration:0.5 angle: -20]];
        
        
        /////////////////////////////////////////
        // Mise en place des séquences
        
        CCSequence* pBuildTower =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:0]],
         [CCDelayTime actionWithDuration: 4.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:1]],
         [CCDelayTime actionWithDuration: 7.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:2]],
         [CCDelayTime actionWithDuration: 10.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:3]],
         [CCDelayTime actionWithDuration: 2.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:4]],
         [CCDelayTime actionWithDuration: 12.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:5]],
         [CCDelayTime actionWithDuration: 5.0f],
         nil];
        
        CCSequence* pAddMoreBlocs =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:6]],
         [CCDelayTime actionWithDuration: 7.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:[NSNumber numberWithInt:7]],
         [CCDelayTime actionWithDuration: 6.0f],
         nil];
        
        NSArray* pRotBloc1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
        NSArray* pRotBloc2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil];
        NSArray* pRotBloc3 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:1], nil];
        NSArray* pRotBloc4 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:2], nil];
        NSArray* pRotBloc5 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:1], nil];
        NSArray* pRotBloc6 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil];
        NSArray* pRotBloc7 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], nil];
        NSArray* pRotBloc8 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
        NSArray* pRotBloc9 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:0], nil];
        NSArray* pRotBloc10 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil];
        NSArray* pRotBloc11 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:0], nil];
        NSArray* pRotBloc12 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:0], nil];
        
        CCSequence* pRotations =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc1],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc2],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc3],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc4],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc5],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc6],
         [CCDelayTime actionWithDuration: 2.1f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotatePlanet:data:) data:[NSNumber numberWithInt:4]],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc7],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc8],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc9],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc10],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc11],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc12],
         [CCDelayTime actionWithDuration: 0.5f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotatePlanet:data:) data:[NSNumber numberWithInt:5]],
         [CCDelayTime actionWithDuration: 2.1f],
         [CCCallFunc actionWithTarget:self selector:@selector(stopAllActions:)],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc7],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc8],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc9],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc10],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc11],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc12],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotatePlanet:data:) data:[NSNumber numberWithInt:4]],
         [CCDelayTime actionWithDuration: 2.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc1],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc2],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc3],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc4],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc5],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotate:data:) data:pRotBloc6],
         [CCCallFuncND actionWithTarget:self selector:@selector(runRotatePlanet:data:) data:[NSNumber numberWithInt:5]],
         [CCDelayTime actionWithDuration: 2.0f],
         [CCCallFunc actionWithTarget:self selector:@selector(stopAllActions:)],
         
         nil];
        
        CCAction* pBalanceTower = [CCRepeat actionWithAction:pRotations times:4];
        
        CCSequence* pRunAll = [CCSequence actions:[CCDelayTime actionWithDuration: i_beginDelay],pBuildTower,pBalanceTower, pAddMoreBlocs, pRotations, nil];
        
        [self runAction:pRunAll];
        
    }
    
    return self;
    
}

- (void) runMoveTo : (id) sender data: (void*) data
{
    NSNumber* index = (NSNumber*) data;
    [[_aBlocs objectAtIndex:[index intValue]] runAction:[_aMoveTo objectAtIndex:[index intValue]]];
}

- (void) runRotate : (id) sender data: (void*) data
{
    NSArray* indexes = (NSArray*) data;
    CCSprite* pBloc = [_aBlocs objectAtIndex:[[indexes objectAtIndex:0] intValue]];
    
    [pBloc runAction:[_aRotate objectAtIndex:[[indexes objectAtIndex:1] intValue]]];

}

- (void) runRotatePlanet : (id) sender data: (void*) data
{
    NSNumber* index = (NSNumber*) data;

    [_pPlanet runAction:[_aRotate objectAtIndex:[index intValue]]];
    
}

- (void) stopAllActions : (id) sender
{
    for (int i = 0 ; i < _aBlocs.count ; i++)
    {
        [[_aBlocs objectAtIndex:i] stopAllActions];
    }
    
    [_pPlanet stopAllActions];
}

@end
