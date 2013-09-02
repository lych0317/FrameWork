/**
 * 播放序列帧动画
 */

@class SequenceImageView;

@protocol SequenceImageViewDelegate <NSObject>

@optional

/**
 * called when did finish animating
 */
- (void)sequenceImageView:(SequenceImageView *)seqIV didFinishAnimating:(BOOL)finish;

/**
 * called when go next image
 */
- (void)sequenceImageView:(SequenceImageView *)seqIV alertNum:(NSInteger)index;

@end

@interface SequenceImageView : UIImageView
{
    NSTimer     *_timer;
    NSInteger   _currentIndex;
}

@property (nonatomic, assign)                            NSInteger                       startIndex;
@property (nonatomic, assign)                            NSInteger                       stopIndex;
@property (nonatomic, copy)                              NSString                        *imageNamePrefix;
@property (nonatomic, copy)                              NSString                        *imageType;
@property (nonatomic, assign, getter = isPositiveSeq)    BOOL                            isPositiveSeq;
@property (nonatomic, assign, getter = isPlayback)       BOOL                            isPlayback;
@property (nonatomic, assign)                            id<SequenceImageViewDelegate>   delegate;

/**
 * start animating
 */
- (void)startAnimatingBySequence;

/**
 * stop animating
 */
- (void)stopAnimatingBySequence;

/**
 * return yes if is animating
 */
- (BOOL)isAnimatingBySequence;

@end
