//
//  StarsLayer.m
//
//  This layer contains the shining stars that appear at night
//

#import "StarsLayer.h"

@implementation StarsLayer

-(id) init
{
    if((self=[super init]))
    {
        
        int minX = 0;
        int maxX = 700;
        
        int minY = 300;
        int maxY = 900;
        
        // Le ciel contiendra 100 étoiles
        for(int i = 0 ; i < 100 ; i++)
        {
            //float posX = (float)(minX + (arc4random() % (maxX - minX)));
            float posX = (float)(minX + (arc4random() % (maxX - minX)));
            float posY = (float)(minY + (arc4random() % (maxY - minY)));
            
            CGPoint position = CGPointMake(posX,posY);
            float opacity = (float)(arc4random() % 100);
            float scale = (float)(30.0f + (arc4random() % 70)) / 100.0f;
            
            CCSprite* pSprite = [[CCSprite alloc] initWithFile:@"star.png"];
            
            pSprite.anchorPoint = ccp(0.0f,0.0f);
            [pSprite setPosition:position];
            [pSprite setOpacity:opacity];
            [pSprite setScale:scale];
            [pSprite setVisible:YES];
            
            [self addChild:pSprite];
            
            float fadeInDuration = (float) (3 + (arc4random() % 8) / 10.0f);
            float fadeOutDuration = (float) (3 + (arc4random() % 8) / 10.0f);

            CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:fadeInDuration opacity:opacity];
            CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:fadeOutDuration opacity:(opacity + (arc4random() % (200)))];
            
            CCSequence *pulseSequence = [CCSequence actionOne:fadeIn two:fadeOut];
            CCRepeatForever *repeat = [CCRepeatForever actionWithAction:pulseSequence];
            [pSprite runAction:repeat];
            
        }
    }
    
    return self;
}
@end
