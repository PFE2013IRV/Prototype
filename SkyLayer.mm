//
//  SkyLayer.m
//
//  Definition of the sky layer. This class implements several mechnanisms for the dynamic sky
//  (gradients, interpolation with noise image...)
//

// Import the interfaces
#import "SkyLayer.h"
#import "math.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


// HelloWorldLayer implementation
@implementation SkyLayer

@synthesize _pAnimation;
@synthesize _pAnimate;
@synthesize _pBackground;
@synthesize _backgroundHeight,_backgroundWidth;
@synthesize _velocityFactor;
@synthesize  _nbSecondToPlay,
_nbSecondPlayed,
_currentMomentOfDay,
_incrementR,
_incrementG,
_incrementB;

@synthesize _currentBackgroundColor;
@synthesize _aimedBackgroundColor;


@synthesize _sceneMod;





// on "init" you need to initialize your instance
-(id) init{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        
        CGSize winSize = [[CCDirector sharedDirector]winSize];
        //Taille à changer!!!
        _backgroundHeight = winSize.height;
        _backgroundWidth = winSize.width;
        
        
        
        
	}
	return self;
}

-(void) initColorsOfDay
{
    _nbSecondToPlay = 120;
    _velocityFactor = 0.1;
    _nbSecondPlayed = 0;
    
    
    
    /* Base couleur */
    
    ccColor4B dawn = ccc4(152, 188, 228, 255);
    ccColor4B morning = ccc4(128, 171, 219, 255);
    ccColor4B middleMorning = ccc4(112, 171, 219, 255);
    ccColor4B noon = ccc4(95, 145, 201, 255);
    ccColor4B afternoon = ccc4(89, 129, 174, 255);
    ccColor4B evening = ccc4(81, 117, 157, 255);
    ccColor4B night = ccc4(67, 98, 132, 255);
    ccColor4B midnight = ccc4(44, 73, 104, 255);
    ccColor4B dark = ccc4(18, 41, 68, 255);

    _aPaintColors[0] = dawn;
    _aPaintColors[1] = morning;
    _aPaintColors[2] = middleMorning;
    _aPaintColors[3] = noon;
    _aPaintColors[4] = afternoon;
    _aPaintColors[5] = evening;
    _aPaintColors[6] = night;
    _aPaintColors[7] = midnight;
    _aPaintColors[8] = dark;
    _aPaintColors[9] = dawn;
    
   
    
    for(int i=1; i<=9;i++)
    {
        _aTimeScale[i-1] = _nbSecondToPlay/9*i;
    }
    
    _currentBackgroundColor = _aPaintColors[0];
    _currentMomentOfDay=0;
    _aimedBackgroundColor = _aPaintColors[_currentMomentOfDay+1];
    
    _incrementR = (_aimedBackgroundColor.r - _currentBackgroundColor.r)/ (_nbSecondToPlay/10);
    _incrementG = (_aimedBackgroundColor.g - _currentBackgroundColor.g)/ (_nbSecondToPlay/10);
    _incrementB = (_aimedBackgroundColor.b - _currentBackgroundColor.b)/ (_nbSecondToPlay/10);
    
    _pAnimation = [[CCAnimation alloc]init];
    
}



-(void) genBackground {
    
    ccColor4F bgColor =  ccc4FFromccc4B(_currentBackgroundColor);
    CCTexture2D *newTexture = [self spriteWithColor:bgColor textureWidth:_backgroundWidth textureHeight:_backgroundHeight];
    
    if (!_pBackground)
    {
        _pBackground = [CCSprite spriteWithTexture:newTexture];
        _pBackground.position = (ccp(_backgroundWidth/2,_backgroundHeight/2));
        [self addChild:_pBackground z:-1];
    }
    else
    {
        [_pBackground setTexture:newTexture];
    }
}


-(CCTexture2D *)spriteWithColor:(ccColor4F)bgColor textureWidth:(float)textureWidth textureHeight:(float)textureHeight {
    
    CCRenderTexture *rt = [CCRenderTexture renderTextureWithWidth:textureWidth height:textureHeight];
    [rt beginWithClear:bgColor.r g:bgColor.g b:bgColor.b a:bgColor.a];
    
    //Dessin dans la texture
    /* Gradient */
    /*
     self.shaderProgram = [[CCShaderCache sharedShaderCache]programForKey:kCCShader_PositionColor];
     CC_NODE_DRAW_SETUP();
     float gradientAlpha = 0.7f;
     int nbSlices = 360;
     float incr = (float) (2* M_PI / nbSlices);
     float radius = textureHeight*2;
     
     CGPoint vertices[nbSlices+2];
     ccColor4F colors[nbSlices+2];
     
     //Le premier point est le centre du cercle , la position du centre du gradient
     vertices[0] = CGPointMake(_pGradientCenter.position.x,_pGradientCenter.position.y);
     //colors[0] = (ccColor4F){_currentSunColor.r,_currentSunColor.g,_currentSunColor.b,gradientAlpha};
     colors[0] = (ccColor4F){227,180,68,gradientAlpha};
     for(int i=0;i<=nbSlices;i++)
     {
     float angle= incr * i;
     float x = (float) cosf(angle)*radius + _pGradientCenter.position.x;
     float y = (float) sinf(angle)*radius + _pGradientCenter.position.y;
     vertices[i+1] = CGPointMake(x, y);
     colors[i+1] = (ccColor4F){0,0,0,0};
     //colors[i+1] = (ccColor4F){_currentSunColor.r,_currentSunColor.g,_currentSunColor.b,0};
     }
     
     ccGLEnableVertexAttribs(kCCVertexAttribFlag_Position | kCCVertexAttribFlag_Color);
     
     glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
     glVertexAttribPointer(kCCVertexAttrib_Color, 4, GL_FLOAT, GL_FALSE, 0, colors);
     glEnable(GL_BLEND);
     glBlendFunc(CC_BLEND, GL_DST_ALPHA);
     glDrawArrays(GL_TRIANGLE_FAN, 0, (GLsizei)nbSlices+2);
     
     /* Noise */
    
    
    CCSprite *noise = [CCSprite spriteWithFile:@"noise.png"];
    [noise setBlendFunc:(ccBlendFunc){GL_DST_COLOR,GL_ZERO}];
    noise.position = ccp(textureWidth/2,textureHeight/2);
    [noise visit];
    
    
    
    [rt end];
    
    return rt.sprite.texture;
    
    
}

-(void) changeBackground:(ccTime)i_dt
{
    
    _nbSecondPlayed ++;
    if(_nbSecondPlayed < _aTimeScale[_currentMomentOfDay])
    {
        ccColor4B newColor = ccc4(_currentBackgroundColor.r + _incrementR, _currentBackgroundColor.g + _incrementG, _currentBackgroundColor.b + _incrementB, 255);
        _currentBackgroundColor = newColor;
        
        
        
        
    }
    else
    {
        _currentMomentOfDay++;
        if(_currentMomentOfDay <9)
        {
            
            _aimedBackgroundColor = _aPaintColors[_currentMomentOfDay+1];
            _incrementR = (_aimedBackgroundColor.r - _currentBackgroundColor.r)/ (_aTimeScale[_currentMomentOfDay]-_aTimeScale[_currentMomentOfDay-1]);
            _incrementG = (_aimedBackgroundColor.g - _currentBackgroundColor.g)/ (_aTimeScale[_currentMomentOfDay]-_aTimeScale[_currentMomentOfDay-1]);
            _incrementB = (_aimedBackgroundColor.b - _currentBackgroundColor.b)/(_aTimeScale[_currentMomentOfDay]-_aTimeScale[_currentMomentOfDay-1]);
            
            ccColor4B newColor = ccc4(_currentBackgroundColor.r + _incrementR, _currentBackgroundColor.g + _incrementG, _currentBackgroundColor.b + _incrementB, 255);
            _currentBackgroundColor = newColor;
            
            
            
            
        }
        else
        {
            _currentMomentOfDay = 0;
            _currentBackgroundColor = _aPaintColors[0];
            _nbSecondPlayed=0;
            
            _aimedBackgroundColor = _aPaintColors[_currentMomentOfDay+1];
            _incrementR = (_aimedBackgroundColor.r - _currentBackgroundColor.r)/ (_aTimeScale[0]);
            _incrementG = (_aimedBackgroundColor.g - _currentBackgroundColor.g)/  (_aTimeScale[0]);
            _incrementB = (_aimedBackgroundColor.b - _currentBackgroundColor.b)/ (_aTimeScale[0]);
            
        }
    }
    [self genBackground ];
}

-(void)ManageBackgroundConstruction
{
    self._sceneMod = SCENE_MODE_CONSTRUCTION;
    [self initColorsOfDay];
    
    [self schedule:@selector(changeBackground:)interval:_velocityFactor];
    
}
-(void)ManageBackgroundBalance
{
    self._sceneMod = SCENE_MODE_BALANCE;
    [self initColorsOfDay];
    
    //On prend une couleur aléatoire comme couleur de fond parmis le tableau des couleurs
    int alea = arc4random() %9;
    self._currentBackgroundColor = _aPaintColors[alea];
    [self genBackground];
    
}




// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
-(void) onEnter
{
    [super onEnter];
    //[self schedule:@selector(changeBackground:)interval:_velocityFactor];
    
}
-(void) onExit
{
    
    [self unschedule:@selector(changeBackground:)];
    [super onExit];
}

@end