/*
 *  Copyright (c) 2016 Spotify AB.
 *
 *  Licensed to the Apache Software Foundation (ASF) under one
 *  or more contributor license agreements.  See the NOTICE file
 *  distributed with this work for additional information
 *  regarding copyright ownership.  The ASF licenses this file
 *  to you under the Apache License, Version 2.0 (the
 *  "License"); you may not use this file except in compliance
 *  with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */

#import "HUBComponentFactoryMock.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUBComponentFactoryMock ()

@property (nonatomic, copy) id<HUBComponent> _Nullable(^componentCreationBlock)(NSString *);

@end

@implementation HUBComponentFactoryMock

- (instancetype)initWithComponents:(NSDictionary<NSString *, id<HUBComponent>> *)components
{
    self = [self initWithBlock:^id<HUBComponent> _Nullable(NSString *name) { return nil; }];
    
    if (self != nil) {
        [self.components addEntriesFromDictionary:components];
    }
    
    return self;
}

- (instancetype)initWithBlock:(id<HUBComponent> _Nullable(^)(NSString *))block
{
    self = [super init];
    
    if (self) {
        _componentCreationBlock = [block copy];
        _components = [NSMutableDictionary new];
    }
    
    return self;
}

#pragma mark - HUBComponentFactory

- (nullable id<HUBComponent>)createComponentForName:(NSString *)name
{
    id<HUBComponent> const component = self.componentCreationBlock(name);
    
    if (component != nil) {
        return component;
    }
    
    return self.components[name];
}

#pragma mark - HUBComponentFactoryShowcaseNameProvider

- (nullable NSString *)showcaseNameForComponentName:(NSString *)componentName
{
    return self.showcaseNamesForComponentNames[componentName];
}

#pragma mark - NSObject

- (BOOL)conformsToProtocol:(Protocol *)protocol
{
    if (protocol == @protocol(HUBComponentFactoryShowcaseNameProvider)) {
        return (self.showcaseableComponentNames != nil || self.showcaseNamesForComponentNames != nil);
    }
    
    return [super conformsToProtocol:protocol];
}

@end

NS_ASSUME_NONNULL_END
