

#import "TransformAnimationHelper.h"

#define TimeForDelay 0.15
#define TimeForInterval 0.04

@implementation TransformAnimationHelper

/**
 * animation for subviews out or in
 */
+ (void)transformAnimationWithViews:(NSArray *)views andWithPoints:(NSArray *)points completion:(void (^)(BOOL finished))completion
{
    for(int i = 0; i < views.count; i++)
    {
        UIView *view = views[i];
        CGPoint point = [points[i] CGPointValue];
        BOOL isEnter = point.x > 0 && point.x < 300;
        UIViewAnimationOptions option = isEnter ? UIViewAnimationOptionCurveEaseIn : UIViewAnimationOptionCurveEaseOut;
        float delay = isEnter ? 0 : TimeForDelay;
        [UIView animateWithDuration:0.1f delay:i == 0 ? delay : (delay + TimeForInterval * i) options:option animations:^{
            view.center = point;
        } completion:^(BOOL finish) {
            if (completion) {
                completion(i == views.count - 1);
            }
        }];
    }
}

@end
