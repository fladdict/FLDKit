//
//  FLDKitAppDelegate.h
//  FLDKit
//
//  Created by 深津 貴之 on 09/08/24.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLDKitViewController;

@interface FLDKitAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FLDKitViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FLDKitViewController *viewController;

@end

