//
//  FLDKitAppDelegate.m
//  FLDKit
//
//  Created by 深津 貴之 on 09/08/24.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FLDKitAppDelegate.h"
#import "FLDKitViewController.h"

@implementation FLDKitAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
