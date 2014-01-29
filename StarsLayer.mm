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
        
        int minX = 50;
        int maxX = 718;
        
        int minY = 450;
        int maxY = 1000;
        
        // Le ciel contiendra 150 étoiles
        for(int i = 0 ; i < 150 ; i++)
        {
            //float posX = (float)(minX + (arc4random() % (maxX - minX)));
            float posX = (float)(minX + (arc4random() % (maxX - minX)));
            float posY = (float)(minY + (arc4random() % (maxY - minY)));
            
            CGPoint position = CGPointMake(posX,posY);
            float opacity = (float)(arc4random() % 100);
            float scale = (float)(1.0f + (arc4random() % 20)) / 100.0f;
            
            CCSprite* pSprite = [[CCSprite alloc] initWithFile:@"Fire_Particle.png"];
            
            pSprite.anchorPoint = ccp(0.0f,0.0f);
            [pSprite setPosition:position];
            [pSprite setOpacity:opacity];
            [pSprite setScale:scale];
            [pSprite setVisible:YES];
            
            [self addChild:pSprite];
            
            float fadeInDuration = (float) (1 + (arc4random() % 6) / 10.0f);
            float fadeOutDuration = (float) (1 + (arc4random() % 6) / 10.0f);

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
