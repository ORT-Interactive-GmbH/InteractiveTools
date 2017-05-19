//
//  ViewController.m
//  InteractiveToolsApp
//
//  Created by Sebastian Westemeyer on 07.10.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

#import "ViewController.h"
#import "IAPushHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)requestPushGrant:(id)sender {
    [IAPushHandler registerForPushNotifications];
}

@end
