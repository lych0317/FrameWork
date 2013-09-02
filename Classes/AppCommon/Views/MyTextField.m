
#import "MyTextField.h"

#define SizeForText 13

@implementation MyTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    [[UIColor colorWithRed:80 green:80 blue:80 alpha:.3] setFill];
    CGSize textSize = [self.placeholder sizeWithFont:[UIFont systemFontOfSize:SizeForText]];
    rect = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - textSize.height) / 2, rect.size.width, rect.size.height);
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:SizeForText]];
}

@end
