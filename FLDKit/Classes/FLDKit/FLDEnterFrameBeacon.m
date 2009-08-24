//
//  FLDEnterFrameBeacon.m
//  FLDView
//
//  Created by 深津 貴之 on 09/08/06.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FLDEnterFrameBeacon.h"

#pragma mark -
#pragma mark private interface

@interface FLDEnterFrameBeaconOperation : NSOperation
{
	id target;
	SEL selector;
	float timeInterval;
	NSTimeInterval lastTimeStamp;
}
@property (assign) id target;
@property (assign) SEL selector;
@property (assign) float timeInterval;
@end

@interface FLDEnterFrameBeacon(private)
-(void)update;
@end



#pragma mark -
#pragma mark implementation

@implementation FLDEnterFrameBeacon

@synthesize fps;
@synthesize isPause;

static FLDEnterFrameBeacon* fld_enterframe_beacon = nil;
+(FLDEnterFrameBeacon*)sharedEnterFrameBeacon
{
	@synchronized(self)
	{
		if(!fld_enterframe_beacon){
			fld_enterframe_beacon = [[FLDEnterFrameBeacon alloc] init];
			fld_enterframe_beacon.fps = 30;
			fld_enterframe_beacon.isPause = NO;
		}
	}
	return fld_enterframe_beacon;
}



#pragma mark -
#pragma mark Listener controll

-(void)addListener:(NSObject*)theObject selector:(SEL)theSelector
{
	//CAN OPTIMIZE
	[self removeListener:theObject selector:theSelector];
	NSArray *keys = [NSArray arrayWithObjects:@"listener",@"selector",nil];
	NSArray *objects = [NSArray arrayWithObjects:theObject, NSStringFromSelector(theSelector),nil]; 
	[listeners addObject: [[[NSDictionary alloc]initWithObjects:objects forKeys:keys]autorelease]];
}

-(void)removeListener:(NSObject*)theObject selector:(SEL)theSelector
{
	NSString *theSelectorString = NSStringFromSelector(theSelector);
	for(int i=[listeners count]-1; i>-1; i--)
	{
		NSDictionary *info = [listeners objectAtIndex:i];
		NSObject *listener = [info objectForKey:@"listener"];
		NSString *selectorStr = [info objectForKey:@"selector"];
		
		if(theObject==listener && [selectorStr isEqualToString: theSelectorString])
		{
			[listeners removeObjectAtIndex:i];
		}
	}
}

-(BOOL)isListener:(NSObject*)theListener selector:(SEL)theSelector
{
	NSString *theSelectorString = NSStringFromSelector(theSelector);
	for(int i=0; i<[listeners count]; i++)
	{
		NSDictionary *info = [listeners objectAtIndex:i];
		NSObject *listener = [info objectForKey:@"listener"];
		NSString *selectorStr = [info objectForKey:@"selector"];
		
		if(listener==theListener && [selectorStr isEqualToString:theSelectorString])
			return YES;
	}
	
	return NO;
}


-(void)setFPS:(int)theValue
{
	fps = theValue;
	enterFrameBeaconOperation.timeInterval = 1.0 / (float)fps;
}

-(void)pause{
	isPause = YES;
}

-(void)resume{
	isPause = NO;
}


#pragma mark -
#pragma mark private

-(id)init{
	if(self=[super init])
	{
		fps = 30;
		listeners = [[NSMutableArray alloc]initWithCapacity:10];
		
		operationQueue = [[NSOperationQueue alloc]init];
		
		FLDEnterFrameBeaconOperation *op = [[FLDEnterFrameBeaconOperation alloc]init];
		op.timeInterval = 1.0 / (float)fps;
		op.target = self;
		op.selector = @selector(update);
		enterFrameBeaconOperation = op;
		[operationQueue addOperation: op];
	}
	return self;
}

-(void)update
{
	if(isPause)
		return;
	
	for(int i=0; i<[listeners count]; i++)
	{
		NSDictionary *info = [listeners objectAtIndex:i];
		NSObject *listener = [info objectForKey:@"listener"];
		NSString *selectorStr = [info objectForKey:@"selector"];
		
		[listener performSelector:NSSelectorFromString(selectorStr) withObject:nil];
	}
}


@end

#pragma mark -
#pragma mark FLDEnterFrameBeaconOperation

@implementation FLDEnterFrameBeaconOperation

@synthesize target;
@synthesize selector;
@synthesize timeInterval;

-(id)init
{
	if(self=[super init]){
		lastTimeStamp = [[NSDate date] timeIntervalSince1970] / 1000.0;
	}
	return self;
}

-(void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	while (![self isCancelled]) {
		[(NSObject*)target performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
		
		NSDate *date = [[NSDate alloc] init];
		NSTimeInterval crntTimeStamp = [date timeIntervalSince1970] / 1000.0;
		NSTimeInterval diff = crntTimeStamp - lastTimeStamp;
		[date release];

		if(diff<timeInterval)
		{
			[NSThread sleepForTimeInterval:(timeInterval-diff)];
		}
	}
	[pool release];
}

@end


