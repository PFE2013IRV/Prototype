//
//  BlocData.m
//  Blocs
//
//  This class provides a data model for the blocs
//

#import "BlocData.h"

@implementation BlocData

@synthesize _aVertices;
@synthesize _eBlocMaterial;
@synthesize _sFileName;
@synthesize _originalSize;
@synthesize _scaledSize;

-(id) initBloc : (NSArray*)i_aVertices withMaterial: (Material)i_eBlocMaterial
{
    if(i_aVertices.count == 0 )
    {
       [NSException raise:NSInternalInconsistencyException format:@"Fatal error : bloc data init failed"];
    }
    
    else if(i_eBlocMaterial == MAT_NULL)
    {
       [NSException raise:NSInternalInconsistencyException format:@"Fatal error : bloc data init failed"];
    }
    
    else if (self = [super init])
    {
        _aVertices = [[NSMutableArray alloc] initWithArray:i_aVertices];
        _eBlocMaterial = i_eBlocMaterial;
        
        
        // Création d'un filename unique associé au PNG.
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef sUUIDString = CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        //NSString* sFolder = [NSString stringWithUTF8String:PNG_FLODER];
        NSString* sPrefix = @"Bloc_";
        NSString* sExtension = @".png";
        
        NSString* sUniqueFileName = [NSString stringWithFormat:@"%@%@%@",sPrefix, (NSString *)sUUIDString, sExtension];
        CFRelease(sUUIDString);
        
        _sFileName = [[NSString alloc] initWithString:sUniqueFileName];
        
        ////////////////////////////////////////////////////////////////
        ///////        Calcul du original size du bloc.            /////
        ////////////////////////////////////////////////////////////////
        
        // Le original size est la taille de la boîte englobante de la forme au moment de sa création
        // (c'est à dire avant rescaling optimal pour le jeu)
    
        // calcul de la distance entre xmax, xmin et ymax, ymin
        
        CGPoint pointTmp = [[_aVertices objectAtIndex:0] CGPointValue];
        int xmin = pointTmp.x;
        int xmax = pointTmp.x;
        int ymin = pointTmp.y;
        int ymax = pointTmp.y;

        for(int i = 1 ; i < _aVertices.count ; i++)
        {
            pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
            int xTmp = pointTmp.x;
            int yTmp = pointTmp.y;
            
            if(xTmp < xmin)
                xmin = xTmp;
            if(yTmp < ymin)
                ymin = yTmp;
            
            if(xTmp > xmax)
                xmax = xTmp;
            if(yTmp > ymax)
                ymax = yTmp;
        }
        
        _originalSize.width = xmax - xmin;
        _originalSize.height = ymax - ymin;
        
        ////////////////////////////////////////////////////////////
        ///////   Calcul du rescaling du bloc à la taille    ///////
        ///////        standard des blocs dans le jeu.       ///////
        ////////////////////////////////////////////////////////////
        
        float scalingFactor = 0.0f;
        float scalingReference = 0.0;
        
        if(_originalSize.width < _originalSize.height)
            scalingReference = _originalSize.width;
        else
            scalingReference = _originalSize.height;
        
        scalingFactor = BLOC_SIZE / scalingReference;
        
        // On calcule les corrdonnées et on les range dans un tableau tampon
        NSMutableArray* aVerticesTmp = [[NSMutableArray alloc] init];
        
        for(int i = 0 ; i < _aVertices.count ; i++)
        {
            // Calcul de chaque coordonnée
            pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
            pointTmp.x = pointTmp.x * scalingFactor;
            pointTmp.y = pointTmp.y * scalingFactor;
            
            NSValue* pointValueTmp = [NSValue valueWithCGPoint:pointTmp];
            [aVerticesTmp addObject:pointValueTmp];
        }
        
        [_aVertices removeAllObjects];
        [_aVertices addObjectsFromArray:aVerticesTmp];
        
        ////////////////////////////////////////////////////////////////
        ///////        Calcul du rescaled size du bloc.            /////
        ////////////////////////////////////////////////////////////////
        
        // Le rescaled size est la taille de la boîte englobante de la forme une fois redimensionnée
        // (c'est à dire après rescaling optimal pour le jeu)
        
        // calcul de la distance entre xmax, xmin et ymax, ymin
        
        pointTmp = [[_aVertices objectAtIndex:0] CGPointValue];
        xmin = pointTmp.x;
        xmax = pointTmp.x;
        ymin = pointTmp.y;
        ymax = pointTmp.y;
        
        for(int i = 1 ; i < _aVertices.count ; i++)
        {
            pointTmp = [[_aVertices objectAtIndex:i] CGPointValue];
            int xTmp = pointTmp.x;
            int yTmp = pointTmp.y;
            
            if(xTmp < xmin)
                xmin = xTmp;
            if(yTmp < ymin)
                ymin = yTmp;
            
            if(xTmp > xmax)
                xmax = xTmp;
            if(yTmp > ymax)
                ymax = yTmp;
        }
        
        _scaledSize.width = xmax - xmin;
        _scaledSize.height = ymax - ymin;


    }
    
    return self;    
}

-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

@end
