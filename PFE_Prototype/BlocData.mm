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
        

        // Calcul du original size du bloc.
        // Le original size est la taille de la boîte englobante de la forme au moment de sa création
        // (c'est à dire avant rescaling optimal pour le jeu)
    
        // calcul de la distance entre xmax, xmin et ymax, ymin
        
        CGPoint point = [[_aVertices objectAtIndex:0] CGPointValue];
        int xmin = point.x;
        int xmax = point.x;
        int ymin = point.y;
        int ymax = point.y;

        for(int i = 1 ; i < _aVertices.count ; i++)
        {
            point = [[_aVertices objectAtIndex:i] CGPointValue];
            int xTmp = point.x;
            int yTmp = point.y;
            
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

    }
    
    return self;    
}

-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

@end
