//
//  FLDScrollView.h
//  FLDView
//
//  Created by 深津 貴之 on 09/08/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark delegate protocol

@class FLDView;
@protocol FLDViewDelegate
@optional
-(void)view:(FLDView*)theView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)view:(FLDView*)theView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)view:(FLDView*)theView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)view:(FLDView*)theView touchesCanceled:(NSSet *)touches withEvent:(UIEvent *)event;
@end

#pragma mark -
#pragma mark class interface

@interface FLDView : UIView {
	id <FLDViewDelegate> delegate;
	float x;
	float y;
	float rotation;
	float scaleX;
	float scaleY;
}

@property (assign) id<FLDViewDelegate> delegate;
@property (assign) float x;
@property (assign) float y;
@property (assign) float rotation;
@property (assign) float scaleX;
@property (assign) float scaleY;
-(void)updateTransform;

@end
