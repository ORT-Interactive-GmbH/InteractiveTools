//
//  IATouchHandlerDelegate.m
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 07.10.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

#import "IATouchHandlerDelegate.h"
#import "IAMessageBoxUtil.h"

@implementation IATouchHandlerDelegate

- (NSArray<UIApplicationShortcutItem *>*) handlerItems {
    // configure shortcuts
    return @[ [[UIApplicationShortcutItem alloc] initWithType:@"type1"
                                               localizedTitle:@"Play"
                                            localizedSubtitle:@"Start playing"
                                                         icon:[UIApplicationShortcutIcon iconWithType: UIApplicationShortcutIconTypePlay]
                                                     userInfo:nil],
              [[UIApplicationShortcutItem alloc] initWithType:@"type2"
                                               localizedTitle:@"Pause"
                                            localizedSubtitle:@"Pause playback"
                                                         icon:[UIApplicationShortcutIcon iconWithType: UIApplicationShortcutIconTypePause]
                                                     userInfo:nil] ];
}

- (BOOL) handleItem: (UIApplicationShortcutItem *) item atIndex: (NSUInteger) idx {
    // handle shortcuts
    switch (idx){
        case 0:
            [IAMessageBoxUtil showMessage:@"Play shortcut handled" title:@"Shortcut handler" once:nil];
            break;
        case 1:
            [IAMessageBoxUtil showMessage:@"Pause shortcut handled" title:@"Shortcut handler" once:nil];
            break;
        default:
            // return NO or implement a default action and return YES
            return NO;
    }
    return YES;
}

@end
