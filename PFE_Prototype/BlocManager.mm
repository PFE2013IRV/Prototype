//
//  BlocManager.m
//  ProjectTower
//
//  The BlocManager is a singleton, capable of drawing a bloc view from a BlocModel,
//  read the blocs in the bloc bag and write new blocs in the bloc bag.
//

#import "BlocManager.h"
#import "BlocBagData.h"
#import "cocos2d.h"

@implementation BlocManager

// Instance variable for the bloc visitor
static BlocManager* pBlocManager = nil;

-(CCSprite*) GetSpriteFromModel: (BlocData*) i_pData
{
    CCSprite* pSprite = nil;
    
    if(i_pData)
    {
        NSLog(@"Begin Bloc Sprite creation");
        
        ////////////////////////////////////////////////////
        // VERIFICATION EXISTENCE DU PNG POUR LE BLOCDATA //
        ////////////////////////////////////////////////////
        
        bool PNGExists = false;
        
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
                if([[sFile substringFromIndex:5] isEqualToString:i_pData._sFileName])
                {
                    PNGExists = true;
                    break;
                }
            }
        }
        else
        {
            // Error handling
            [NSException raise:NSInternalInconsistencyException format:@"Error : documents directory culd not be reached"];
        }
        
        // Si le PNG associé n'existe pas encore, on le crée
        if(!PNGExists)
            [self MakePNGFromModel:i_pData];
        
        ////////////////////////
        // CREATION DU SPRITE //
        ////////////////////////
        
        NSString* sPathWithFileName = [sDocumentsDirectory stringByAppendingPathComponent:i_pData._sFileName];
        
        pSprite = [[[CCSprite alloc] initWithFile:sPathWithFileName] autorelease];
        
        NSLog(@"End Bloc Sprite creation");
    }
    
    return pSprite;
}


-(void) SaveBloc: (BlocData*) i_pData
{
    if(i_pData)
    {
        NSLog(@"Begin Save Bloc");
        
        
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
        
        // Path du fichier JSON
        NSString* sResourcePath = [[NSBundle mainBundle] resourcePath];
        NSString * sFilePath = [sResourcePath stringByAppendingString:@"/BlocBagData.json"];
        NSError* pError = nil;
        NSData* pJsonData = [NSData dataWithContentsOfFile:sFilePath];
        
        // Le contenu du fichier JSON est accessible via cet objet
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:pJsonData options:NSJSONReadingMutableContainers error:&pError];
        
        if(!pError)
        {
            // Bloc Bag Size
            NSString* sSize = [jsonObjects objectForKey:@"Size"];
            BagSize blocBagSize = (BagSize) [sSize intValue];

            // Blocs
            NSDictionary* aAllBlocs = [jsonObjects objectForKey:@"Blocs"];
            
            // Array of BlocData for BlocBagData
            NSMutableArray* aBlocsRet = [[NSMutableArray alloc] init];
            
            for(NSDictionary* aBloc in aAllBlocs)
            {
                
                // Material
                NSString* sMaterial = [aBloc objectForKey:@"Material"];
                Material materialRet = (Material)[sMaterial intValue];
                
                // Points
                NSDictionary* aPoints = [aBloc objectForKey:@"Points"];
                NSMutableArray* aPointsRet = [[NSMutableArray alloc] init];
                
                for(NSDictionary* aPointValues in aPoints)
                {
                    NSString* sX = [aPointValues objectForKey:@"x"];
                    NSString* sY = [aPointValues objectForKey:@"y"];
                    
                    int x = [sX intValue];
                    int y = [sY intValue];
                    
                    CGPoint point = CGPointMake(x, y);
                    NSValue* pPointValueRet = [NSValue valueWithCGPoint:point];
                    
                    [aPointsRet addObject:pPointValueRet];
                    
                }
                
                // Init BlocData and add it to the return array
                BlocData* pBlocData = [[BlocData alloc] initBloc:aPointsRet withMaterial:materialRet];
                [aBlocsRet addObject:pBlocData];
            }
            
            // Add extracted info to the BlocBagData
            [pBlocBagData SetBlocBagData:blocBagSize withBlocs:aBlocsRet];
        }
        else
        {
            [NSException raise:NSInternalInconsistencyException format:@"Error : bloc bag save file could not be found."];
        }
        
        NSLog(@"End load bloc data");
    }
    else
    {
        [NSException raise:NSInternalInconsistencyException format:@"Error : BlocBagData instance could not be reached."];
    }
}

-(void) MakePNGFromModel: (BlocData*) i_pData
{
    if(i_pData)
    {
        NSLog(@"Begin write PNG Bloc");
        
        int originalWidth = i_pData._scaledSize.width;
        int originalHeight = i_pData._scaledSize.height;
        
        // On instancie un CCRednerTexture dans lequel nous allons créer le rendu du bloc
        CCRenderTexture* pRenderTexture = [CCRenderTexture renderTextureWithWidth:originalWidth height:originalHeight];
        
        // On commence le rendu avec une texture transparente.
        [pRenderTexture beginWithClear:0 g:0 b:0 a:0];
        
        // On dessine dans la texture.
        
        // Calque 1 : lignes
        
        NSMutableArray* aVertices = i_pData._aDrawingVertices;
        
        glEnable(GL_LINE_LOOP);
        ccDrawColor4B(209, 75, 75, 255);
        
        float lineWidth = 8.0 * CC_CONTENT_SCALE_FACTOR();
        glLineWidth(lineWidth);
        
        for(int i = 1 ; i < aVertices.count ; i++)
        {
            NSValue* pGetPointA = [aVertices objectAtIndex:i-1];
            NSValue* pGetPointB = [aVertices objectAtIndex:i];
            
            CGPoint pointA = [pGetPointA CGPointValue];
            CGPoint pointB = [pGetPointB CGPointValue];
            
            ccDrawLine(pointA, pointB);
        }
        
        // On ferme la forme
        NSValue* pGetPointA = [aVertices firstObject];
        NSValue* pGetPointB = [aVertices lastObject];
        
        CGPoint pointA = [pGetPointA CGPointValue];
        CGPoint pointB = [pGetPointB CGPointValue];
        ccDrawLine(pointA, pointB);
        
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

-(void) MoveBlocData: (BlocData*) i_pData withX: (float) i_x withY: (float) i_y
{
    if(i_pData)
    {
        // Décallage du centre de gravité
        CGPoint gravityCenter = CGPointMake(i_pData._gravityCenter.x + i_x, i_pData._gravityCenter.y + i_y);
        i_pData._gravityCenter = gravityCenter;
        
        // A DISCUTER :
        // Faut-il aussi bouger tous les points ou le centre de gravité suffit-il ?
    }
    
}

-(void) MoveBlocDataToBubble: (BlocData*) i_pData
{
    if(i_pData)
    {
        // Calcul du vecteur de translation entre le centre de gravité courant et le bubble point.
        // Après translation, le centre de gravité du bloc data sera confondu avec le bubble point.
        CGPoint translation = CGPointMake(i_pData._gravityCenter.x - BUBBLE_POINT.x, i_pData._gravityCenter.y - BUBBLE_POINT.y);
        
        [self MoveBlocData:i_pData withX:translation.x withY:translation.y];
    }
}


+(BlocManager*) GetBlocManager
{
    if(!pBlocManager)
    {
        [[self alloc] init];
    }
    
    return pBlocManager;
}

+(id) alloc
{
    pBlocManager = [super alloc];
    return pBlocManager;
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
