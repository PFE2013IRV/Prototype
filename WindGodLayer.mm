//
//  WindGodLayer.mm
//
//  This layer contains the wind god's sprites, spritesheets, animations.
//

#import "WindGodLayer.h"
#import "LevelVisitor.h"

@implementation WindGodLayer


@synthesize _pGodData;
@synthesize _pCurrGameData;

#define FLOAT(x) [NSNumber numberWithFloat:x]

-(id) init
{
    // Animations par défaut (Dieu du feu)
    NSMutableArray* aAnims = [[NSMutableArray alloc]
    initWithObjects:@"moveUp",@"moveDown",@"static1",@"static2",@"static3", nil];
    
    NSArray* aDelays = [[NSArray alloc] initWithObjects:FLOAT(0.2), nil];
    
    GodType eDefaultGod = GOD_TYPE_NULL;
    
	if( (self=[super initWithGod:eDefaultGod withAnims:aAnims withDelays:aDelays]))
    {
   

        _godIsUp = YES;
        
        // On lance la série d'actions par défaut : les anims static
        [self moveWindGod: nil];

	}
    
	return self;
}

- (void) playWindStaticAnims : (id) sender
{
    // On stoppe toutes les séquences d'actions précédentes
    
    
    // On refraichit l'information sur le dieu du vent
    // au cas où celle-ci ait changé
    [self refreshWindGodInfo];
    
    CCSequence* pSequence = nil;

    // On met en place une séquence d'animations alternant static1 et static2
    pSequence =
    [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static1"],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static3"],
         [CCDelayTime actionWithDuration: 4.0f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static1"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static2"],
         [CCDelayTime actionWithDuration: 2.4f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static2"],
    nil];

    // La séquence se joue "pour toujours"
    //... ou du moins jusqu'à ce qu'on l'arrête nous mêmes !
    CCSequence* pSequenceForever = [CCSequence actions:
                                    [CCRepeatForever actionWithAction:pSequence],
                                    nil];
    
    [self runAction:pSequenceForever];
}

- (void) refreshWindGodInfo
{
    // On regarde à quel dieu on à faire et remet à jour la variable de colère
    _pCurrGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
    _pGodData = _pCurrGameData._pWindGodData;
    
    _godIsUp = _pGodData._godIsUp;
    _currentPosition = _pGodData._windGodPosition;
    
}


-(void) moveWindGod : (id) sender
{
    
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllActions];
    [self stopAllRuningAnimations:nil];
    
    // On refraichit l'information sur le dieu du vent
    // au cas où celle-ci ait changé
    [self refreshWindGodInfo];
    
    
    NSArray* aMoveData;
    NSValue* pGoalValue;
    NSNumber* pDuration = FLOAT(1.6);
    
    CCSequence* pSequence = nil;

    if(_godIsUp == YES)
    {
        // On init les données du moveTo
        CGPoint goalPosition = ccp(630, 232);
        pGoalValue = [NSValue valueWithCGPoint:goalPosition];
        
        aMoveData = [[NSArray alloc] initWithObjects:@"moveDown",pGoalValue,pDuration, nil];
        
        pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"moveDown"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:aMoveData],
         [CCDelayTime actionWithDuration: 2.8f],
         [CCCallFunc actionWithTarget:self selector:@selector(playWindStaticAnims:)],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"moveDown"],
         nil];
        
        _godIsUp = NO;
        _pGodData._godIsUp = NO;
        _pGodData._windGodPosition = goalPosition;
    }
    else
    {
        // On init les données du moveTo
        CGPoint goalPosition = ccp(630, 700);
        pGoalValue = [NSValue valueWithCGPoint:goalPosition];
        
        aMoveData = [[NSArray alloc] initWithObjects:@"moveUp",pGoalValue,pDuration, nil];
        
        pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"moveUp"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runMoveTo:data:) data:aMoveData],
         [CCDelayTime actionWithDuration: 2.8f],
         [CCCallFunc actionWithTarget:self selector:@selector(playWindStaticAnims:)],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"moveUp"],
         nil];
        
        _godIsUp = YES;
        _pGodData._godIsUp = YES;
        _pGodData._windGodPosition = goalPosition;
    }
    
    
    [self runAction:pSequence];
}

- (void) playCuteAnim : (id) sender
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations:nil];
    
    // On refraichit l'information sur le dieu du vent
    // au cas où celle-ci ait changé
    [self refreshWindGodInfo];
    
    CCSequence* pSequence = nil;
    
    // On met en place une séquence d'animations alternant static1 et static2
    pSequence =
    [CCSequence actions:
     [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static3"],
     [CCDelayTime actionWithDuration: 2.6f],
     [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static3"],
     nil];
    
    // La séquence se joue "pour toujours"
    //... ou du moins jusqu'à ce qu'on l'arrête nous mêmes !
    CCSequence* pSequenceForever = [CCSequence actions:
                                    [CCRepeatForever actionWithAction:pSequence],
                                    nil];
    
    [self runAction:pSequenceForever];
    
}



@end

