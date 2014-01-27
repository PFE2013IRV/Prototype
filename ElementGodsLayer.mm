//
//  ElementGodsLayer.mm
//
//  This layer implements the animation sequences for all the elementary gods (fire, water, earth)
//

#import "ElementGodsLayer.h"
#import "LevelVisitor.h"
#import "GodData.h"
#import "GameScene.h"

@implementation ElementGodsLayer

@synthesize _pGodParticle;
@synthesize _pGodData;
@synthesize _pCurrGameData;
@synthesize _isAngry;

#define FLOAT(x) [NSNumber numberWithFloat:x]

-(id) init
{
    // Animations par défaut (Dieu du feu)
    NSMutableArray* aAnims = [[NSMutableArray alloc] initWithObjects:@"static1",@"static2",@"static3",@"colere1",@"colere2",@"wind", nil];
    
    NSArray* aDelays = [[NSArray alloc] initWithObjects:FLOAT(0.1), nil];
    
    GodType eDefaultGod = GOD_TYPE_FIRE;
    
	if( (self=[super initWithGod:eDefaultGod withAnims:aAnims withDelays:aDelays]))
    {

        // On lance la séquence d'actions par défaut : les animations FireGod_static
        
        [self playElementaryStaticAnims: nil];
       
        ///////////////////////////////////////////////////////////////////
        ///////     Initialisations des effets de particules dieux    /////
        ///////////////////////////////////////////////////////////////////
        
        _pGodParticle=[[CCParticleSystemQuad alloc] initWithFile:@"godParticle.plist"];
        

	}
	return self;
}

- (void) refreshElementaryGodInfo
{
    // On regarde à quel dieu on à faire et remet à jour la variable de colère
    _pCurrGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
    _pGodData = [_pCurrGameData getCurrentGod];
    
    _isAngry = _pGodData._isAngry;
    _eCurrentGod = _pGodData._eGodType;
}

- (void) playElementaryStaticAnims  : (id) sender
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    [self refreshElementaryGodInfo];
    
    CCSequence* pSequence = nil;
    
        // On met en place une séquence d'animations alternant static1 et static2
    pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static1"],
         [CCDelayTime actionWithDuration: 3.2f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static1"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static2"],
         [CCDelayTime actionWithDuration: 2.4f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static2"],
    nil];

    
    // La séquence se joue "pour toujours"
    //... ou du moins jusqu'à ce qu'on l'arrête nous mêmes !
    CCAction* pSequenceForever = [CCRepeatForever actionWithAction:pSequence];
    
    [self runAction:pSequenceForever];
}

-(void) playAngerAnim : (id) sender
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    [self refreshElementaryGodInfo];
    
    CCSequence* pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"colere1"],
         [CCDelayTime actionWithDuration: 1.6f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"colere1"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static3"],
         nil];
    
    [self runAction:pSequence];
}

-(void) playCalmDownAnim : (id) sender
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    [self refreshElementaryGodInfo];
    
    CCSequence* pSequence =
    [CCSequence actions:
     [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"colere2"],
     [CCDelayTime actionWithDuration: 1.6f],
     [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"colere2"],
     [CCCallFunc actionWithTarget:self selector:@selector(playElementaryStaticAnims:)],
     nil];
    
    [self runAction:pSequence];
}

-(void) playWindAnim : (id) sender
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    [self refreshElementaryGodInfo];
    
    CCSequence* pSequence =
    [CCSequence actions:
     [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"wind"],
     [CCDelayTime actionWithDuration: 1.5f],
     [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"wind"],
     nil];
    
    [self runAction:pSequence];
}



@end
