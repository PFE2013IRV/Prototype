//
//  BlocVisitor.m
//  ProjectTower
//
//  The BlocVisitor is a singleton, capable to draw a bloc view from a BlocModel,
//  read the blocs in the bloc bag and write new blocs in the bloc bag.
//

#import "BlocVisitor.h"
#import "BlocBagData.h"
#import "cocos2d.h"

@implementation BlocVisitor

// Instance variable for the bloc visitor
static BlocVisitor* pBlocVisitor = nil;

-(CCSprite*) GetSpriteFromModel: (BlocData*) i_pData
{
    CCSprite* pSprite = nil;
    
    if(i_pData)
    {
        NSLog(@"Begin Bloc Sprite creation");
        
        pSprite = [[[CCSprite alloc] init] autorelease];
        
        // To be implemented : create a sprite from a Bloc Data
        
        NSLog(@"End Bloc Sprite creation");
    }
    return pSprite;
}


-(void) SaveBloc: (BlocData*) i_pData
{
    if(i_pData)
    {
        NSLog(@"Begin Save Bloc");
        // To be implemented : writing the data in the save file
        
        NSLog(@"End Save Bloc");
    }
    else
    {
        NSLog(@"Error : bloc could not be saved. Data was corrupted");
    }
}


-(void) LoadBlocsToBlocBag
{
    BlocBagData* pBlocBagData = nil;
    // Get the bloc bag data instance
    pBlocBagData = [BlocBagData GetBlocBagData];
    
    if(pBlocBagData)
    {
        NSLog(@"Begin load bloc data");
        
        //  To be implemented : retrieve data from the save file and load it to the bloc bag data
        
        NSLog(@"End load bloc data");
    }
    else
    {
        [NSException raise:NSInternalInconsistencyException format:@"Error : bloc could not load the blocs. Data was corrupted"];
    }
}

static int coords[6][2] =
{
    {50, 100},
    {230, 250},
    {50, 250},
    {150, 100},
    {90, 35},
    {300, 160}
};

-(void) MakePNGFromModel: (BlocData*) i_pData
{
    if(i_pData)
    {
        NSLog(@"Begin write PNG Bloc");
        
        int originalWidth = i_pData._originalSize.width;
        int originalHeight = i_pData._originalSize.height;
        
        // On instancie un CCRednerTexture dans lequel nous allons créer le rendu du bloc
        CCRenderTexture* pRenderTexture = [CCRenderTexture renderTextureWithWidth:originalWidth height:originalHeight];
        
        // On commence le rendu avec une texture transparente.
        [pRenderTexture beginWithClear:0 g:0 b:0 a:0];
        
        // On dessine dans la texture.
        
        // Calque 1 : lignes
        
        NSMutableArray* aVertices = i_pData._aVertices;
        
        glEnable(GL_LINE_LOOP);
        ccDrawColor4B(209, 75, 75, 255);
        
        float lineWidth = 8.0 * CC_CONTENT_SCALE_FACTOR();
        glLineWidth(lineWidth);
        
        for(int i = 1 ; i < aVertices.count-1 ; i++)
        {
            NSValue* pGetPointA = [aVertices objectAtIndex:i-1];
            NSValue* pGetPointB = [aVertices objectAtIndex:i];
            
            CGPoint pointA = [pGetPointA CGPointValue];
            CGPoint pointB = [pGetPointB CGPointValue];
            
            ccDrawLine(pointA, pointB);
        }
        
        
        // Fin du rendu
        [pRenderTexture end];
        
        [pRenderTexture saveToFile:@"test.png" format:kCCImageFormatPNG];
        
        NSLog(@"End write PNG Bloc");
        
        
    }
    else
    {
        [NSException raise:NSInternalInconsistencyException format:@"Error : bloc could write PNG file. Data was corrupted"];
    }
}

+(BlocVisitor*) GetBlocVisitor
{
    if(!pBlocVisitor)
    {
        [[self alloc] init];
    }
    
    return pBlocVisitor;
}

+(id) alloc
{
    pBlocVisitor = [super alloc];
    return pBlocVisitor;
}

-(id) init
{
    
    if(self = [super init])
    {
        // Init of the bloc visitor
    }
    
    return self;
}


@end
