//
//  PopShadowView.h
//  AliyunOSSiOS
//
//  Created by xzming on 2018/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopShadowView : UIView

@property(nonatomic, copy)void (^onTouchShadow)(void);

@end

NS_ASSUME_NONNULL_END
