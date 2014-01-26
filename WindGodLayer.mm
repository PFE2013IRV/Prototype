//
//  WindGodLayer.mm
//
//  This layer contains the wind god's sprites, spritesheets, animations.
//

#import "WindGodLayer.h"

@implementation WindGodLayer


-(id) init
{
    // Animations par défaut (Dieu du feu)
    NSMutableArray* aAnims = [[NSMutableArray alloc] initWithObjects:@"moveUp", nil];
    GodType eDefaultGod = GOD_TYPE_NULL;
    
	if( (self=[super initWithGod:eDefaultGod withAnims:aAnims]))
    {
   
        // On lance l'action par défaut : WindGod_static1
        
        _godIsUp = NO;
        //[self moveWindGod];
	}
    
	return self;
}
/*
-(void) moveWindGod (id)sender data: (void *)data
{
    NSString* sAnimName = (NSString*) data;

    if(_godIsUp == YES)
    {
        sAnimName = @"moveDown";
        [self loadAnim:sAnimName];
        _pWindGod.position = ccp(590, 600);
        goalPosition = ccp(590, 232);
        _godIsUp = NO;
    }
    else
    {
        sAnimName = @"moveUp";
        [self loadAnim:sAnimName];
        goalPosition = ccp(590, 600);
        _pWindGod.position = ccp(590, 232);
        _godIsUp = YES;
    }
    
    
    [_pWindGod stopAllActions];
    [_pWindGod runAction:[_aWindGodActions objectForKey:[sWindGod stringByAppendingString:sAnimName]]];
    [_pWindGod runAction:pMoveAction];
}

-(void) playMoveUpAnim
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    //[self refreshElementaryGodInfo];
    
    CCAction* pMoveAction = [CCMoveTo actionWithDuration:1.5 position:goalPosition];
    
    CCSequence* pSequence =
    [CCSequence actions:
     [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"colere1"],
     [CCDelayTime actionWithDuration: 1.6f],
     [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"colere1"],
     [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static3"],
     nil];
    
    [self runAction:pSequence];
}
*/

@end

