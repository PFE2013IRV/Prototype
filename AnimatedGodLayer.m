//
//  AnimatedGodLayer.m
//
//
//  Base class for all the animated gods (fire, water, earth and wind)
//  Defines all the base behaviors for animations and animations cycles.
//

#define FLOAT(x) [NSNumber numberWithFloat:x]

#import "AnimatedGodLayer.h"

@implementation AnimatedGodLayer


- (id) initWithGod: (GodType) i_eGodType withAnims: (NSMutableArray*) i_aAnimStrings  withDelays: (NSArray*) i_aDelays
{
    if( (self=[super init]) )
    {
        
        float delayDefault = 0.0f;
        
        // On traite les delais
        if(i_aDelays.count == 0 || (i_aDelays.count < i_aAnimStrings.count && i_aDelays.count > 1))
        {
            [NSException raise:NSInternalInconsistencyException format:@"Fatal Error : please give a correct size for the delays array"];
        }
        else
        {
            if(i_aDelays.count == 1)
                delayDefault = [[i_aDelays objectAtIndex:0] floatValue];
        }
        
        
        // On récupère le type de dieu
        _eGodType = i_eGodType;
        NSString* sGodType;
        
        if(_eGodType == GOD_TYPE_FIRE)
            sGodType = @"FireGod_";
        else if(_eGodType == GOD_TYPE_WATER)
            sGodType = @"WaterGod_";
        else if(_eGodType == GOD_TYPE_EARTH)
            sGodType = @"EarthGod_";
        else
            sGodType = @"WindGod_";
        
        
        self._aGodSpriteSheets = [[[NSMutableDictionary alloc] init] autorelease];
        self._aGodActions = [[[NSMutableDictionary alloc] init] autorelease];
        self._aGodSprites = [[[NSMutableDictionary alloc] init] autorelease];
        
        
        for(int i = 0; i < i_aAnimStrings.count; i++)
        {
            // Création du string du nom de l'animation complet avec le nom du dieu.
            NSString* sAnimName = [i_aAnimStrings objectAtIndex:i];
            NSString* sAnimNameWithGod = [sGodType stringByAppendingString:sAnimName];
            
            ///////////////////////////////////////////////////////////////////
            ///////        Création des actions pour les dieux            /////
            ///////////////////////////////////////////////////////////////////
            
            // On charge les plists relatives aux différentes spritesheets
            NSString* sPlistName = [sAnimNameWithGod stringByAppendingString:@".plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:sPlistName];
            
            // On récupère le nombre de frames
            sPlistName = [[NSBundle mainBundle] pathForResource:sAnimNameWithGod ofType:@"plist"];
            NSDictionary* aPlistInfo = [NSDictionary dictionaryWithContentsOfFile:sPlistName];
            int nbFrames = [[aPlistInfo objectForKey:@"frames"] count];
            
            // On charge les spritesheets en elles-mêmes et on les conserve dans un dictionnaire.
            
            NSString* sPngName = [sAnimNameWithGod stringByAppendingString:@".png"];
            CCSpriteBatchNode* pSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:sPngName];
            
            [self._aGodSpriteSheets setObject:pSpriteBatchNode forKey:sAnimNameWithGod];
            
            // Le spritesheet devient fils du layer
            [self addChild:[self._aGodSpriteSheets objectForKey:sAnimNameWithGod]];
            
            ///////////////////////
            // Pour chaque spritesheet, on découpe en frames que l'on va conserver dans des tableaux tampons, le temps de l'initialisation.
            
            NSMutableArray* aFramesTmp = [NSMutableArray array];
            NSString* sFirstFrameName;
            
            for(int j = 1; j <= nbFrames ; j++)
            {
                NSString* sFrameName = [sAnimName stringByAppendingString:[NSString stringWithFormat:@"_%d.png",j]];
                
                // On conserve le nom du first frame (pour l'init des sprites)
                if(j == 1)
                    sFirstFrameName = [NSString stringWithString:sFrameName];
                
                [aFramesTmp addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:sFrameName]];
            }
            
            // On initialise pour chaque spritesheet une animation
            // avec les bons delais renseignés par l'utilisateur de la classe
            
            float delay = 0.0f;
            
            if (delayDefault == 0.0f)
            {
                delay = [[i_aDelays objectAtIndex:i] floatValue];
            }
            else
            {
                delay = delayDefault;
            }
            
            
            CCAnimation* pAnimation = [CCAnimation
                                       animationWithSpriteFrames:aFramesTmp delay:delay];
            
            // On initialise les différentes actions du Dieu et on les conserve dans un dictionnaire
            
            CCAction* pAction = [CCRepeatForever actionWithAction:
                                 [CCAnimate actionWithAnimation:pAnimation]];
            [self._aGodActions setObject:pAction forKey:sAnimNameWithGod];
            
            ///////////////////////////////////////////////////////////////////
            ///////        Initialisations des sprites des dieux          /////
            ///////////////////////////////////////////////////////////////////
            
            // Instance
            CCSprite* pSprite = [[CCSprite spriteWithSpriteFrameName:sFirstFrameName] autorelease];
            
            // Rangement
            [self._aGodSprites setObject:pSprite forKey:sAnimNameWithGod];
            
            // Filiation au spritesheet correspondant
            [[self._aGodSpriteSheets objectForKey:sAnimNameWithGod] addChild:pSprite];
            
            // Attributs par défaut
            if(_eGodType == GOD_TYPE_FIRE || _eGodType == GOD_TYPE_EARTH || _eGodType == GOD_TYPE_WATER)
            {
                pSprite.position = ccp(90, 733);
                [pSprite setScale:0.8];
            }
            else
            {
                pSprite.anchorPoint = ccp(0.0f,0.0f);
                pSprite.position = ccp(630, 700);
                [pSprite setScale:0.6];
            }
            
            pSprite.visible = NO;
            
        }
	}
	return self;
}

- (void) runAnim: (id)sender data: (void *)data
{
    // On récupère le type de dieu pour lequel il faut lancer l'animation
    NSString* sGodType;
    
    if(_eGodType == GOD_TYPE_FIRE)
        sGodType = @"FireGod_";
    else if(_eGodType == GOD_TYPE_WATER)
        sGodType = @"WaterGod_";
    else if(_eGodType == GOD_TYPE_EARTH)
        sGodType = @"EarthGod_";
    else
        sGodType = @"WindGod_";
    
    NSString* sAnimName = [sGodType stringByAppendingString:(NSString*) data];
    CCSprite* pAnimSprite = (CCSprite*) [self._aGodSprites objectForKey:sAnimName];
    
    //[pAnimSprite stopAllActions];
    [pAnimSprite setVisible:YES];
    
    [pAnimSprite runAction:[self._aGodActions objectForKey:sAnimName]];
    
}

- (void) stopAnim: (id)sender data: (void *)data
{
    // On récupère le type de dieu pour lequel il faut stopper l'animation
    NSString* sGodType;
    
    if(_eGodType == GOD_TYPE_FIRE)
        sGodType = @"FireGod_";
    else if(_eGodType == GOD_TYPE_WATER)
        sGodType = @"WaterGod_";
    else if(_eGodType == GOD_TYPE_EARTH)
        sGodType = @"EarthGod_";
    else
        sGodType = @"WindGod_";
    
    NSString* sAnimName = [sGodType stringByAppendingString:(NSString*) data];
    CCSprite* pAnimSprite = (CCSprite*) [self._aGodSprites objectForKey:sAnimName];
    
    [pAnimSprite stopAllActions];
    

    [pAnimSprite setVisible:NO];
    
}


- (void) stopAllRuningAnimations: (id)sender
{
    // On arrête toutes les actions sur les sprites du Dieu concerné.
    NSMutableDictionary* aCurrentDico;
    aCurrentDico = [NSMutableDictionary dictionaryWithDictionary:self._aGodSprites];
    
    for(id sKey in aCurrentDico)
    {
        CCSprite* pSprite = [aCurrentDico objectForKey:sKey];
        [pSprite stopAllActions];
        [pSprite setVisible:NO];
    }
    
    // On arrête toutes les séquences en cours sur le layer.
    [self stopAllActions];
}

- (void) runMoveTo: (id) sender data: (void*) data
{
    // On récupère le type de dieu pour lequel il faut lancer l'animation
    NSString* sGodType;
    
    if(_eGodType == GOD_TYPE_FIRE)
        sGodType = @"FireGod_";
    else if(_eGodType == GOD_TYPE_WATER)
        sGodType = @"WaterGod_";
    else if(_eGodType == GOD_TYPE_EARTH)
        sGodType = @"EarthGod_";
    else
        sGodType = @"WindGod_";
    
    // On cast la data vers un array et on extrait l'info
    NSArray* aData = (NSArray*) data;
    NSString* sAnimName = [sGodType stringByAppendingString:[aData objectAtIndex:0]];
    NSValue* pGoalValue = [aData objectAtIndex:1];
    NSNumber* pDuration = [aData objectAtIndex:2];

    // On lance l'action !
    CCSprite* pAnimSprite = (CCSprite*) [self._aGodSprites objectForKey:sAnimName];
    CCAction* pMoveAction = [CCMoveTo actionWithDuration:pDuration.floatValue position:[pGoalValue CGPointValue]];
    
    [pAnimSprite runAction:pMoveAction];
    
    // On remet à jour la position de tous les autres sprites du dieu
    // (sauf celui qui a eu le moveTo)
    for(NSString* key in self._aGodSprites)
    {
        if(![key isEqualToString:sAnimName]){
            CCSprite* pSprite = [self._aGodSprites objectForKey:key];
            pSprite.position = [pGoalValue CGPointValue];
        }
        
    }
    
}

- (void) requestBigCleanUp
{
    for(CCSpriteBatchNode* pSpriteSheet in self._aGodSpriteSheets)
    {
        [pSpriteSheet removeAllChildren];
        
        //[pSpriteSheet removeAllChildrenWithCleanup:true];
    }

}

@end
