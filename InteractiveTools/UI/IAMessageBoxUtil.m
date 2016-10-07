//
//  IAMessageBoxUtil.m
//
//  Created by Sebastian Westemeyer on 23.02.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//
#import "IAMessageBoxUtil.h"

@implementation IAMessageBoxUtil

+ (void)showErrorMessage:(nullable NSError *)error {
    [self showErrorMessage:error
                   actions:@[
                       [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                              handler:^(UIAlertAction *action){
                                              }]
                   ]];
}

+ (void)showErrorMessage:(nullable NSError *)error actions:(nonnull NSArray<UIAlertAction *> *)actions {
    if (error != nil && error.localizedDescription != nil) {
        [self showMessage:NSLocalizedString(error.localizedDescription, nil)
                    title:NSLocalizedString(@"Error", nil)
                     once:nil
                  actions:actions];
    }
}

+ (void)showMessage:(nonnull NSString *)message title:(nonnull NSString *)title once:(nullable NSString *)onlyOnceId {
    [self showMessage:message
                title:title
                 once:onlyOnceId
              actions:@[
                  [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                         handler:^(UIAlertAction *action){
                                         }]
              ]];
}

+ (void)showMessage:(nonnull NSString *)message
              title:(nonnull NSString *)title
               once:(nullable NSString *)onlyOnceId
            actions:(nonnull NSArray<UIAlertAction *> *)actions {
    BOOL displayOnce = [self displayOnce:onlyOnceId];

    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;

    if (onlyOnceId == nil || displayOnce) {
        UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

        for (UIAlertAction *action in actions) {
            [alert addAction:action];
        }

        [controller presentViewController:alert animated:YES completion:nil];

        if (displayOnce) {
            [self displayedOnce:onlyOnceId];
        }
    }
}

+ (BOOL)displayOnce:(NSString *)onlyOnceId {
    if (onlyOnceId == nil)
        return NO;

    return ![[NSUserDefaults standardUserDefaults] boolForKey:onlyOnceId];
}

+ (void)displayedOnce:(NSString *)onlyOnceId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:onlyOnceId];
    [userDefaults synchronize];
}

@end

@implementation UIAlertAction (TSMessageBoxUtil)

+ (instancetype __nonnull)actionWithTitle:(nullable NSString *)title handler:(void (^__nullable)(UIAlertAction *__nonnull action))handler {
    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
}

@end
