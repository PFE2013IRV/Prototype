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

+(CCSprite*) GetSpriteFromModel: (BlocData*) i_pData
{
    CCSprite* pSprite = nil;
    
    if(i_pData)
    {
        
        BlocBagData* pBBD = [BlocBagData GetBlocBagData];
        NSMutableArray* aTextures = pBBD._aBlocTextures;
        CCTexture2D* pTexture = [aTextures objectAtIndex:i_pData._indexInBlocBag];
        pSprite = [CCSprite spriteWithTexture:pTexture];
        pSprite.flipY = YES;
        
    }
    
    return pSprite;
}

+(CCPhysicsSprite*) GetPhysicsSpriteFromModel: (BlocData*) i_pData
{
    CCPhysicsSprite* pSprite = nil;
    
    if(i_pData)
    {
        NSLog(@"Begin Bloc Sprite creation");
        
        
        BlocBagData* pBBD = [BlocBagData GetBlocBagData];
        NSMutableArray* aTextures = pBBD._aBlocTextures;
        CCTexture2D* pTexture = [aTextures objectAtIndex:i_pData._indexInBlocBag];
        pSprite =[CCPhysicsSprite spriteWithTexture:pTexture];
        pSprite.flipY = YES;
        
        
        NSLog(@"End Bloc Sprite creation");
    }
    
    return pSprite;
}


- (CCSprite*) GetTexturedSprite: (BlocData*) i_pData
{
    // On récupère le path du documents directory
    NSArray* aPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* sDocumentsDirectory = [aPaths objectAtIndex:0];
    
    NSString* sPathWithFileName = [sDocumentsDirectory stringByAppendingPathComponent:i_pData._sFileName];
    
    CCSprite* pMaskSprite = [[CCSprite alloc] initWithFile:sPathWithFileName] ;
    pMaskSprite.flipY = YES;

    if(!SIMULATOR_MODE)
    {
        
        NSString* sSuffix = @"_texture.png";
        NSString* sTextureFileName;
        
        if(i_pData._eBlocMaterial == MAT_WOOD)
            sTextureFileName = [@"Wood" stringByAppendingString:sSuffix];
        else if(i_pData._eBlocMaterial == MAT_GLASS)
            sTextureFileName = [@"Glass" stringByAppendingString:sSuffix];
        
        CCSprite* pTextureSprite = [CCSprite spriteWithFile:sTextureFileName] ;
        
        CCRenderTexture* pRt = [CCRenderTexture renderTextureWithWidth:pMaskSprite.contentSize.width height:pMaskSprite.contentSize.height];
        
        float dx = pTextureSprite.position.x - pMaskSprite.position.x;
        float dy = pTextureSprite.position.y - pMaskSprite.position.y;
        
        
        pMaskSprite.position = ccp(pMaskSprite.contentSize.width/2 * pMaskSprite.scale, pMaskSprite.contentSize.height/2 * pMaskSprite.scale);
        pTextureSprite.position = ccp(pTextureSprite.position.x + dx, pTextureSprite.position.y + dy);
        
        [pMaskSprite setBlendFunc:(ccBlendFunc){GL_ONE, GL_ZERO}];
        [pTextureSprite setBlendFunc:(ccBlendFunc){GL_DST_ALPHA, GL_ZERO}];
        
        
        [pRt begin];
        [pMaskSprite visit];
        [pTextureSprite visit];
        [pRt end];
        
        CCSprite* pResult = [CCSprite spriteWithTexture:pRt.sprite.texture];
        pResult.flipY = YES;
        
        [pRt removeFromParentAndCleanup:YES];
        
        return pResult;
    }
    else
    {
        return pMaskSprite;
        
    }
    
    
}


+(NSString*) GetNameOfPictureFromModel: (BlocData*) i_pData
{
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
        
        ////////////////////////
        // CREATION DU SPRITE //
        ////////////////////////
        
        return [sDocumentsDirectory stringByAppendingPathComponent:i_pData._sFileName];
    }
    else
    {
        return @"";
    }
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
    
    [self DeletePNGFiles];
    
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
            
            int indexInBlocBag = 0;
            
            for(NSDictionary* aBloc in aAllBlocs)
            {
                
                // Material
                NSString* sMaterial = [aBloc objectForKey:@"Material"];
                Material materialRet = (Material)[sMaterial intValue];
                NSString* sRespect = [aBloc objectForKey:@"Respect"];
                
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
                BlocData* pBlocData = [[BlocData alloc] initBloc:aPointsRet withMaterial:materialRet GodRespect:[sRespect intValue]];
                pBlocData._indexInBlocBag = indexInBlocBag;
                [aBlocsRet addObject:pBlocData];
                
                
                [self MakePNGMask:pBlocData];
                
                indexInBlocBag++;
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

-(void) MakePNGMask: (BlocData*) i_pData
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
        
        NSMutableArray* aVertices = i_pData._aDrawingVertices;
        int nbVertices = aVertices.count;
        CGPoint vertices[nbVertices];
        
        for(int i = 0; i < nbVertices ; i++)
        {
            vertices[i] = [[aVertices objectAtIndex:i] CGPointValue];
            vertices[i].y = originalHeight - vertices[i].y;
        }
        
        ccDrawSolidPoly(vertices, nbVertices,ccc4f(209.0f, 75.0f, 75.0f, 255.0f));
        
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
        
        // A DISCUTER : Mise à jour de tous les points de _aVertices
        NSMutableArray* aVerticesTmp = [[NSMutableArray alloc] initWithArray:i_pData._aVertices];
        for(int i = 0 ; i < aVerticesTmp.count; i++)
        {
            CGPoint pointTmp = [[aVerticesTmp objectAtIndex:i] CGPointValue];
            pointTmp.x += i_x;
            pointTmp.y += i_y;
            NSValue* replaceValue = [NSValue valueWithCGPoint:pointTmp];
            
            [i_pData._aVertices replaceObjectAtIndex:i withObject:replaceValue];
        }
    }
}

-(void) MoveBlocDataToBubble: (BlocData*) i_pData
{
    if(i_pData)
    {
        // Calcul du vecteur de translation entre le centre de gravité courant et le bubble point.
        // Après translation, le centre de gravité du bloc data sera confondu avec le bubble point.
        CGPoint translation = CGPointMake(i_pData._gravityCenter.x - BUBBLE_POINT_X, i_pData._gravityCenter.y - BUBBLE_POINT_Y);
        
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
        [self LoadBlocsToBlocBag];
    }
    
    return self;
}


@end
