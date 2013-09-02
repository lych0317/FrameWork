/**
 * 播放序列帧动画
 */

#import "SequenceImageView.h"

@implementation SequenceImageView

@synthesize startIndex           = _startIndex;
@synthesize stopIndex            = _stopIndex;
@synthesize imageNamePrefix      = _imageNamePrefix;
@synthesize imageType            = _imageType;
@synthesize isPositiveSeq        = _isPositiveSeq;
@synthesize isPlayback           = _isPlayback;
@synthesize delegate             = _delegate;

#pragma mark -
#pragma mark system method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isPositiveSeq = YES;
        _isPlayback = NO;
        _imageType = @"png";
    }
    return self;
}

/**
 * set start index
 */
- (void)setStartIndex:(NSInteger)startIndex
{
    _currentIndex = startIndex;
    _startIndex = startIndex;
}

#pragma mark -
#pragma mark selector method
/**
 * go to next image if not to stop index
 */
- (void)goToNextImage
{
    _currentIndex += _isPositiveSeq ? 1 : -1;
    if ([_delegate respondsToSelector:@selector(sequenceImageView:alertNum:)])
    {
        [_delegate sequenceImageView:self alertNum:_currentIndex];
    }
    NSString *imageName = [NSString stringWithFormat:@"%@%d", _imageNamePrefix, _currentIndex];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:_imageType]];
    [self setImage:image];
    if (_isPlayback)
    {
        if (_currentIndex == _stopIndex)
        {
            _isPositiveSeq = !_isPositiveSeq;
        }
        if (_currentIndex == _startIndex)
        {
            [self stopAnimatingBySequence];
            if ([_delegate respondsToSelector:@selector(sequenceImageView:didFinishAnimating:)])
            {
                [_delegate sequenceImageView:self didFinishAnimating:YES];
            }
        }
    }
    else
    {
        if (_currentIndex == _stopIndex)
        {
            [self stopAnimatingBySequence];
            if ([_delegate respondsToSelector:@selector(sequenceImageView:didFinishAnimating:)])
            {
                [_delegate sequenceImageView:self didFinishAnimating:YES];
            }
        }
    }
}

#pragma mark -
#pragma mark public method
/**
 * start nstimer to start animating
 */
- (void)startAnimatingBySequence
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:.04 target:self selector:@selector(goToNextImage) userInfo:nil repeats:YES];
    self.userInteractionEnabled = NO;
}

/**
 * stop nstimer to stop animating
 */
- (void)stopAnimatingBySequence
{
    _currentIndex = _startIndex;
    [_timer invalidate];
    _timer = nil;
    self.userInteractionEnabled = YES;
}

/**
 * return yes if nstimer is valid
 */
- (BOOL)isAnimatingBySequence
{
    return [_timer isValid];
}

@end
