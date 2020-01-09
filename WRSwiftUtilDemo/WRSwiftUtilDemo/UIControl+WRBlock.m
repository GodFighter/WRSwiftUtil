//
//  UIControl+WRBlocks.m
//  WRKitDemo
//
//  Created by xianghui on 2017/8/17.
//  Copyright © 2017年 xianghui. All rights reserved.
//

#import <objc/runtime.h>
#import "UIControl+WRBlock.h"

static const void *WRControlHandlersKey = &WRControlHandlersKey;

@interface WRControlWrapper : NSObject <NSCopying>

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);

@end

@implementation WRControlWrapper

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents {
    self = [super init];
    if (!self) return nil;
    
    self.handler = handler;
    self.controlEvents = controlEvents;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[WRControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender {
    self.handler(sender);
}

@end

#pragma mark - Category
@implementation UIControl (WRBlocks)

- (void)wr_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents {
    NSParameterAssert(handler);
    NSMutableDictionary *events = objc_getAssociatedObject(self, WRControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, WRControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    
    WRControlWrapper *target = [[WRControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
    [handlers addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}

@end
