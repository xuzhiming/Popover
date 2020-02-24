
#import "PopoverViewCell.h"
#import <Masonry/Masonry.h>

// extern
float const PopoverViewCellHorizontalMargin = 15.f; ///< 水平边距
float const PopoverViewCellVerticalMargin = 3.f; ///< 垂直边距
float const PopoverViewCellTitleLeftEdge = 8.f; ///< 标题左边边距

@interface PopoverViewCell ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation PopoverViewCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // initialize
    [self initialize];

    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = _style == PopoverViewStyleDefault ? [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00] : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }
}

#pragma mark - Setter
- (void)setStyle:(PopoverViewStyle)style {
    _style = style;
    _bottomLine.backgroundColor = [self.class bottomLineColorForStyle:style];
    if (_style == PopoverViewStyleDefault) {
        [_button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    } else {
        [_button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }
}

#pragma mark - Private
// 初始化
- (void)initialize {
    // UI
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.userInteractionEnabled = NO; // has no use for UserInteraction.
//    _button.translatesAutoresizingMaskIntoConstraints = NO;
    _button.titleLabel.font = [self.class titleFont];
    _button.titleLabel.numberOfLines = 0;
    _button.backgroundColor = self.contentView.backgroundColor;
//    _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.contentView addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

    // Constraint
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{ @"margin": @(PopoverViewCellHorizontalMargin) } views:NSDictionaryOfVariableBindings(_button)]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{ @"margin": @(PopoverViewCellVerticalMargin) } views:NSDictionaryOfVariableBindings(_button)]];
    // 底部线条
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00];
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:bottomLine];
    _bottomLine = bottomLine;
    // Constraint
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1.f);
    }];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomLine]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(bottomLine)]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLine(lineHeight)]|" options:kNilOptions metrics:@{ @"lineHeight": @(1 / [UIScreen mainScreen].scale) } views:NSDictionaryOfVariableBindings(bottomLine)]];
}

#pragma mark - Public
/*! @brief 标题字体 */
+ (UIFont *)titleFont {
    return [UIFont systemFontOfSize:14.f];
}

/*! @brief 底部线条颜色 */
+ (UIColor *)bottomLineColorForStyle:(PopoverViewStyle)style {
    return style == PopoverViewStyleDefault ? [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00] : [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.00];
}

- (void)setAction:(PopoverAction *)action {
    [_button setImage:action.image forState:UIControlStateNormal];
    [_button setTitle:action.title forState:UIControlStateNormal];
    if (action.image) {
//        [_button setImageEdgeInsets:UIEdgeInsetsMake(0, PopoverViewCellTitleLeftEdge, 0, 0)];
        [_button.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(PopoverViewCellHorizontalMargin).priorityHigh();
            make.right.equalTo(self.button.titleLabel.mas_left).offset(-PopoverViewCellTitleLeftEdge);
            make.centerY.equalTo(self.button);
            make.size.mas_equalTo(action.image.size);
        }];

    } else {
        [_button.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(PopoverViewCellTitleLeftEdge);
            make.center.equalTo(self.button);
        }];
    }

    _button.titleEdgeInsets = action.image ? UIEdgeInsetsMake(0, PopoverViewCellTitleLeftEdge, 0, -PopoverViewCellTitleLeftEdge) : UIEdgeInsetsZero;
}

- (void)showBottomLine:(BOOL)show {
    _bottomLine.hidden = !show;
}

@end
