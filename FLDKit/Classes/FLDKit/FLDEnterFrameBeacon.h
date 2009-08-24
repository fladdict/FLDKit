//
//  FLDEnterFrameBeacon.h
//  FLDView
//
//  Created by 深津 貴之 on 09/08/06.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLDEnterFrameBeaconOperation;

@interface FLDEnterFrameBeacon : NSObject {
	NSMutableArray *listeners;
	NSOperationQueue *operationQueue;
	BOOL isPause;
	FLDEnterFrameBeaconOperation *enterFrameBeaconOperation;
	int fps;
}

@property (assign) int fps;
@property (assign) BOOL isPause;

+(FLDEnterFrameBeacon*)sharedEnterFrameBeacon;

-(void)addListener:(NSObject*)theListener selector:(SEL)theSelector;
-(void)removeListener:(NSObject*)theListener selector:(SEL)theSelector;
-(BOOL)isListener:(NSObject*)theListener selector:(SEL)theSelector;

@end
