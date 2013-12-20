//
//  AppDelegate.h
//  PFE_Prototype
//
//  Created by Karim Le Nir Aboul-Enein on 20/12/2013.
//  Copyright Karim Le Nir Aboul-Enein 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end


// Ce commentaire dans la AppDelegate est un test de versioning

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;
	
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
