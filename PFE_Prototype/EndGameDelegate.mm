//
//  EndGameDelegate.m
//  PFE_Prototype
//
//  Created by Maximilien on 2/11/14.
//  Copyright (c) 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "EndGameDelegate.h"
#import "cocos2d.h"

@interface EndGameDelegate ()

@end

@implementation EndGameDelegate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[CCDirector sharedDirector] pause];
        UIAlertView* popUpEnd = [[UIAlertView alloc] init];
        [popUpEnd setDelegate:self];
        [popUpEnd setTitle:@"Fin du jeu !"];
        [popUpEnd setMessage:@"Félicitation vous avez terminé la partie !"];
        [popUpEnd addButtonWithTitle:@"Revenir au menu"];
        [popUpEnd show];
        [popUpEnd release];
    }
    return self;
}


 -(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     
    [[CCDirector sharedDirector] popToRootScene];
   }


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
