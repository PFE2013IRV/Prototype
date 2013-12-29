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

-(void) MakePNGFromModel: (BlocData*) i_pData
{
    if(i_pData)
    {
        NSLog(@"Begin write PNG Bloc");
        
        int originalWidth = 400;//i_pData._originalSize.width;
        int originalHeight = 400;//i_pData._originalSize.height;
        
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
        
        [pRenderTexture saveToFile:i_pData._sFileName format:kCCImageFormatPNG];
        
        NSLog(@"End write PNG Bloc");
        
    }
    else
    {
        [NSException raise:NSInternalInconsistencyException format:@"Error : bloc could write PNG file. Data was corrupted"];
    }
}

-(void) DeletePNGFiles
{
    // On récupère le path du documents directory
    NSArray* aPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* sDocumentsDirectory = [aPaths objectAtIndex:0];
    
    // On initialise un file manager
    NSFileManager* pFileManager = [[[NSFileManager alloc] init] autorelease];
    NSError* pError = nil;
    NSArray* aDirectoryContents = [pFileManager contentsOfDirectoryAtPath:sDocumentsDirectory error:&pError];
    if (pError == nil)
    {
        for (NSString* sFile in aDirectoryContents)
        {
            // Seuls les fichiers préfixés de "Bloc_" sont concernés
            
            if([[sFile substringToIndex:5] isEqualToString:@"Bloc_"])
            {
                NSString* sPathWithFileName = [sDocumentsDirectory stringByAppendingPathComponent:sFile];
                
                BOOL removeSuccess = [pFileManager removeItemAtPath:sPathWithFileName error:&pError];
                if (!removeSuccess)
                {
                    // Error handling
                    [NSException raise:NSInternalInconsistencyException format:@"Error : Bloc could not be deleted"];
                }
            }
        }
    }
    else
    {
        // Error handling
        [NSException raise:NSInternalInconsistencyException format:@"Error : documents directory culd not be reached"];
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
