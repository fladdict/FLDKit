//
//  FLDScrollView.m
//  FLDView
//
//  Created by 深津 貴之 on 09/08/05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FLDView.h"


@implementation FLDView

@synthesize delegate;
@synthesize x;
@synthesize y;
@synthesize rotation;
@synthesize scaleX;
@synthesize scaleY;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        x = 0;
		y = 0;
		rotation = 0;
		scaleX = 1.0;
		scaleY = 1.0;
		
		//we dont user setFrame, setCenter and setBound anymore.
		[self setCenter: CGPointMake(0,0)];
    }
    return self;
}

- (void)updateTransform
{
	CGAffineTransform trns = CGAffineTransformMake(1.0,0.0,0.0,1.0,0.0,0.0);
	trns = CGAffineTransformTranslate(trns, x, y);
	trns = CGAffineTransformRotate(trns, rotation * 3.141592 / 180.0);
	trns = CGAffineTransformScale(trns, scaleX, scaleY);
	[self setTransform:trns];
}


#pragma mark -
#pragma mark TouchDelegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(delegate && [(NSObject*)delegate respondsToSelector:@selector(view:touchesBegan:withEvent:)]){
		[delegate view:self touchesBegan:touches withEvent:event];
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(delegate && [(NSObject*)delegate respondsToSelector:@selector(view:touchesMoved:withEvent:)]){
		[delegate view:self touchesMoved:touches withEvent:event];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(delegate && [(NSObject*)delegate respondsToSelector:@selector(view:touchesEnded:withEvent:)]){
		[delegate view:self touchesEnded:touches withEvent:event];
	}
}

-(void)touchesCanceled:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(delegate && [(NSObject*)delegate respondsToSelector:@selector(view:touchesCanceled:withEvent:)]){
		[delegate view:self touchesCanceled:touches withEvent:event];
	}
}

@end
