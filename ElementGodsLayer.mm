//
//  ElementGodsLayer.mm
//
//  This layer implements the animation sequences for all the elementary gods (fire, water, earth)
//

#import "ElementGodsLayer.h"
#import "LevelVisitor.h"
#import "GodData.h"

@implementation ElementGodsLayer

@synthesize _pGodParticle;
@synthesize _pGodData;
@synthesize _pCurrGameData;

-(id) init
{
    // Animations par défaut (Dieu du feu)
    NSMutableArray* aAnims = [[NSMutableArray alloc] initWithObjects:@"static1",@"static2",@"static3",@"colere1", nil];
    
    GodType eDefaultGod = GOD_TYPE_FIRE;
    
	if( (self=[super initWithGod:eDefaultGod withAnims:aAnims]))
    {

        // On lance la séquence d'actions par défaut : les animations FireGod_static
        
        [self playElementaryStaticAnims];
       
        ///////////////////////////////////////////////////////////////////
        ///////     Initialisations des effets de particules dieux    /////
        ///////////////////////////////////////////////////////////////////
        
        _pGodParticle=[[CCParticleSystemQuad alloc] initWithFile:@"godParticle.plist"];
        
        // Bouton God
        CCMenuItemImage *addParticleGodFireButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addGodParticle:)];
        addParticleGodFireButton.position = ccp(80, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleGodFireButton, nil];
        addMenu.position = ccp(0, 170);
        
        // ajoute le menu
        [self addChild:addMenu];

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

- (void) playElementaryStaticAnims
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    [self refreshElementaryGodInfo];
    
    CCSequence* pSequence = nil;
    
    if(_isAngry == NO)
    {
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
       
    }
    else if(_isAngry == YES)
    {
        // On met en place une séquence d'animations
        //Update Max : Sequence de retour du dieu à la normale ==> bug?
        
         /*
          pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static3"],
         nil];
          */
        
        /* changement temporaire MAX : Remise brutal de l'anim de base sans annim de transition.
         a voir pour Karim si il existe une en sens inverse quand le dieu se calme -noir=>blanc-
         */
        pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static1"],
         [CCDelayTime actionWithDuration: 3.2f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static1"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static2"],
         [CCDelayTime actionWithDuration: 2.4f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static2"],
         nil];
         
        
           }
    
    // La séquence se joue "pour toujours"
    //... ou du moins jusqu'à ce qu'on l'arrête nous mêmes !
    CCAction* pSequenceForever = [CCRepeatForever actionWithAction:pSequence];
    
    [self runAction:pSequenceForever];
}

-(void) playAngerAnim
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

-(void)addGodParticle:(id)i_boutonClic
{
    //Update Max : changement du dieu en cours _isAngry ici ou ailleurs? je n'ai pas trouvé ailleurs
    if (_pGodParticle.parent != self) {
        if(_pGodData._isAngry == YES)
        {
           _pGodData._isAngry = FALSE;
        }
        else
        {
            _pGodData._isAngry = YES;
        }
        [self addChild:_pGodParticle];
        [self playAngerAnim];
    }
    else if (_pGodParticle.parent == self){
        
        if(_pGodData._isAngry == YES)
        {
            _pGodData._isAngry = FALSE;
        }
        else
        {
            _pGodData._isAngry = YES;
        }
        [self playElementaryStaticAnims];
        [self removeChild:_pGodParticle cleanup:false];
    }
}

-(void)addGodParticle
{
    if (_pGodParticle.parent != self) {
        [self addChild:_pGodParticle];
        [self playAngerAnim];
    }
    else if (_pGodParticle.parent == self)
    {
        [self playElementaryStaticAnims];
        [self removeChild:_pGodParticle cleanup:false];
    }
}

@end
