#import "TGSecretModernConversationAccessoryTimerView.h"

#import <LegacyComponents/LegacyComponents.h>

#import <LegacyComponents/TGModernButton.h>

#import "TGPresentation.h"

@interface TGSecretModernConversationAccessoryTimerView ()
{
    TGModernButton *_timerButton;
    UIImageView *_timerIconView;
    UILabel *_timeLabel;
}

@end

@implementation TGSecretModernConversationAccessoryTimerView

- (id)init
{
    CGFloat height = 33.0f;
    CGFloat offset = -3.0f;

    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 24.0f, height)];
    if (self)
    {
        _timerButton = [[TGModernButton alloc] initWithFrame:CGRectMake(0.0f, offset, 24.0f, height)];
        _timerButton.modernHighlight = true;
        [_timerButton addTarget:self action:@selector(timerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_timerButton];
        
        _timerIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 24.0f, 26.0f)];
        _timerIconView.frame = CGRectOffset(_timerIconView.frame, CGFloor((_timerButton.frame.size.width - _timerIconView.frame.size.width) / 2.0f) - 6.0f - TGScreenPixel, 5.0f - TGScreenPixel);
        [_timerButton addSubview:_timerIconView];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = TGSystemFontOfSize(16.0f);
        _timeLabel.hidden = true;
        [_timerButton addSubview:_timeLabel];
    }
    return self;
}

- (void)setPresentation:(TGPresentation *)presentation
{
    _presentation = presentation;
    
    _timerIconView.image = presentation.images.chatInputTimerIcon;
    _timeLabel.textColor = presentation.pallete.chatInputFieldButtonColor;
}

- (void)sizeToFit
{
    CGFloat height = 33.0f;
    
    CGSize size = CGSizeMake(27.0f, height);
    if (_timerValue == 0)
    {
    }
    else
    {
        [_timeLabel sizeToFit];
        size.width = MAX(size.width, _timeLabel.frame.size.width);
    }
}

- (void)setTimerValue:(NSInteger)timerValue
{
    if (_timerValue != timerValue)
    {
        _timerValue = timerValue;
        
        if (_timerValue == 0)
        {
            _timerIconView.hidden = false;
            _timeLabel.hidden = true;
        }
        else
        {
            _timerIconView.hidden = true;
            _timeLabel.hidden = false;
            _timeLabel.text = [self stringForSecretTimer:_timerValue];
            [_timeLabel sizeToFit];
            _timeLabel.frame = CGRectMake(CGFloor((_timerButton.frame.size.width - _timeLabel.frame.size.width) / 2.0f) - 8.0f, 9.0f, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
        }
    }
}

- (NSString *)stringForSecretTimer:(NSInteger)value
{
    if (value == 0)
        return @"";
    else
        return [TGStringUtils stringForShortMessageTimerSeconds:value];
    
    return [[NSString alloc] initWithFormat:@"%ds", (int)value];
}

- (void)timerButtonPressed
{
    id<TGSecretModernConversationAccessoryTimerViewDelegate> delegate = _delegate;
    if ([delegate respondsToSelector:@selector(accessoryTimerViewPressed:)])
        [delegate accessoryTimerViewPressed:self];
}

@end
