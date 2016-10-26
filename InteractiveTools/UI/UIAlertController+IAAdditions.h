//
//  UIAlertController+IAAdditionss.h
//
//  Created by Sebastian Westemeyer on 23.02.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (IAAdditions)

+ (void)showMessage:(nonnull NSString *)message title:(nonnull NSString *)title once:(nullable NSString *)onlyOnceId;

+ (void)showErrorMessage:(nullable NSError *)error;

+ (void)showErrorMessage:(nullable NSError *)error actions:(nonnull NSArray<UIAlertAction *> *)actions;

+ (void)showMessage:(nonnull NSString *)message
              title:(nonnull NSString *)title
               once:(nullable NSString *)onlyOnceId
            actions:(nonnull NSArray<UIAlertAction *> *)actions;

+ (void)showMessage:(nonnull NSString *)message
              title:(nonnull NSString *)title
         controller:(nonnull UIViewController *)controller
               once:(nullable NSString *)onlyOnceId
            actions:(nonnull NSArray<UIAlertAction *> *)actions;

@end

@interface UIAlertAction (IAAdditions)

+ (instancetype __nonnull)actionWithTitle:(nullable NSString *)title handler:(void (^__nullable)(UIAlertAction *__nonnull action))handler;

@end
