//
//  RNTextInputMask.m
//  RNTextInputMask
//
//  Created by Ivan Zotov on 7/29/17.
//
//

#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTUIManager.h>
#import <React/RCTEventDispatcher.h>
#import "RCTTextField.h"
#import "RNTextInputMask.h"
#import "MaskedTextFieldDelegate.h"

@implementation RNTextInputMask
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue {
    return self.bridge.uiManager.methodQueue;
}

RCT_EXPORT_METHOD(setMask:(nonnull NSNumber *)reactNode mask:(NSString *)mask) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry ) {
        UIView *view = viewRegistry[reactNode];
        RCTTextField *textView = ((RCTTextField *)view);

        dispatch_async(dispatch_get_main_queue(), ^{
            MaskedTextFieldDelegate *maskedDelegate = [MaskedTextFieldDelegate format:mask]
            maskedDelegate.listener = self
            textView.delegate = maskedDelegate
        });
    }];
}
@end
