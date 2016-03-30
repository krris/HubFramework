#import "HUBViewModelLoaderImplementation.h"

#import "HUBConnectivityStateResolver.h"
#import "HUBContentProvider.h"
#import "HUBJSONSchema.h"
#import "HUBViewModelBuilderImplementation.h"
#import "HUBViewModelImplementation.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUBViewModelLoaderImplementation () <HUBContentProviderDelegate>

@property (nonatomic, copy, readonly) NSURL *viewURI;
@property (nonatomic, copy, readonly) NSString *featureIdentifier;
@property (nonatomic, copy, readonly) NSString *defaultComponentNamespace;
@property (nonatomic, copy, readonly) NSArray<id<HUBContentProvider>> *contentProviders;
@property (nonatomic, strong, readonly) id<HUBJSONSchema> JSONSchema;
@property (nonatomic, strong, readonly) id<HUBConnectivityStateResolver> connectivityStateResolver;
@property (nonatomic, strong, nullable) id<HUBViewModel> cachedInitialViewModel;
@property (nonatomic, strong, nullable) HUBViewModelBuilderImplementation *builder;
@property (nonatomic, strong, nullable) NSMutableArray<id<HUBContentProvider>> *contentProviderQueue;
@property (nonatomic, strong, nullable) NSError *encounteredError;

@end

@implementation HUBViewModelLoaderImplementation

@synthesize delegate = _delegate;

#pragma mark - Public API

- (instancetype)initWithViewURI:(NSURL *)viewURI
              featureIdentifier:(NSString *)featureIdentifier
      defaultComponentNamespace:(NSString *)defaultComponentNamespace
               contentProviders:(NSArray<id<HUBContentProvider>> *)contentProviders
                     JSONSchema:(id<HUBJSONSchema>)JSONSchema
      connectivityStateResolver:(id<HUBConnectivityStateResolver>)connectivityStateResolver
               initialViewModel:(nullable id<HUBViewModel>)initialViewModel
{
    NSParameterAssert(viewURI != nil);
    NSParameterAssert(featureIdentifier != nil);
    NSParameterAssert(defaultComponentNamespace != nil);
    NSParameterAssert(contentProviders.count > 0);
    NSParameterAssert(JSONSchema != nil);
    NSParameterAssert(connectivityStateResolver != nil);
    
    self = [super init];
    
    if (self) {
        _viewURI = [viewURI copy];
        _featureIdentifier = [featureIdentifier copy];
        _defaultComponentNamespace = [defaultComponentNamespace copy];
        _contentProviders = [contentProviders copy];
        _JSONSchema = JSONSchema;
        _connectivityStateResolver = connectivityStateResolver;
        _cachedInitialViewModel = initialViewModel;
        
        for (id<HUBContentProvider> const contentProvider in _contentProviders) {
            contentProvider.delegate = self;
        }
    }
    
    return self;
}

#pragma mark - HUBViewModelLoader

- (nullable id<HUBViewModel>)initialViewModel
{
    id<HUBViewModel> const cachedInitialViewModel = self.cachedInitialViewModel;
    
    if (cachedInitialViewModel != nil) {
        return cachedInitialViewModel;
    }
    
    HUBViewModelBuilderImplementation * const builder = [self createBuilder];
    
    for (id<HUBContentProvider> const contentProvider in self.contentProviders) {
        [contentProvider addInitialContentForViewURI:self.viewURI toViewModelBuilder:builder];
    }
    
    id<HUBViewModel> const initialViewModel = [builder build];
    self.cachedInitialViewModel = initialViewModel;
    return initialViewModel;
}

- (void)loadViewModel
{
    self.builder = nil;
    self.contentProviderQueue = [self.contentProviders mutableCopy];
    [self loadNextContentProviderInQueue];
}

#pragma mark - HUBContentProviderDelegate

- (void)contentProviderDidFinishLoading:(id<HUBContentProvider>)contentProvider
{
    [self handleFinishedContentProvider:contentProvider mode:HUBContentProviderModeAsynchronous error:nil];
}

- (void)contentProvider:(id<HUBContentProvider>)contentProvider didFailLoadingWithError:(NSError *)error
{
    [self handleFinishedContentProvider:contentProvider mode:HUBContentProviderModeAsynchronous error:error];
}

#pragma mark - Private utilities

- (HUBViewModelBuilderImplementation *)getOrCreateBuilder
{
    if (self.builder == nil) {
        self.builder = [self createBuilder];
    }
    
    HUBViewModelBuilderImplementation * const builder = self.builder;
    return builder;
}
                                             
- (HUBViewModelBuilderImplementation *)createBuilder
{
    return [[HUBViewModelBuilderImplementation alloc] initWithFeatureIdentifier:self.featureIdentifier
                                                                     JSONSchema:self.JSONSchema
                                                      defaultComponentNamespace:self.defaultComponentNamespace];
}

- (void)loadNextContentProviderInQueue
{
    id<HUBContentProvider> const contentProvider = [self.contentProviderQueue firstObject];
    
    if (contentProvider == nil) {
        [self allContentProvidersDidFinish];
        return;
    }
    
    HUBConnectivityState const connectivityState = [self.connectivityStateResolver resolveConnectivityState];
    id<HUBViewModelBuilder> const builder = [self getOrCreateBuilder];
    
    HUBContentProviderMode const contentProviderMode = [contentProvider loadContentForViewURI:self.viewURI
                                                                            connectivityState:connectivityState
                                                                             viewModelBuilder:builder
                                                                 previousContentProviderError:self.encounteredError];
    
    switch (contentProviderMode) {
        case HUBContentProviderModeNone:
        case HUBContentProviderModeSynchronous:
            [self handleFinishedContentProvider:contentProvider mode:contentProviderMode error:nil];
            break;
        case HUBContentProviderModeAsynchronous:
            break;
    }
}

- (void)handleFinishedContentProvider:(id<HUBContentProvider>)contentProvider mode:(HUBContentProviderMode)mode error:(nullable NSError *)error
{
    if (mode != HUBContentProviderModeNone) {
        self.encounteredError = error;
    }
    
    if ([self.contentProviderQueue firstObject] != contentProvider) {
        if (error == nil && self.contentProviderQueue.count == 0) {
            [self allContentProvidersDidFinish];
        }
        
        return;
    }
    
    [self.contentProviderQueue removeObjectAtIndex:0];
    [self loadNextContentProviderInQueue];
}

- (void)allContentProvidersDidFinish
{
    id<HUBViewModelLoaderDelegate> const delegate = self.delegate;
    
    if (delegate == nil) {
        return;
    }
    
    if (self.encounteredError == nil) {
        if (self.builder == nil) {
            return;
        }
        
        id<HUBViewModel> const viewModel = [self.builder build];
        [delegate viewModelLoader:self didLoadViewModel:viewModel];
    } else {
        NSError * const error = self.encounteredError;
        [delegate viewModelLoader:self didFailLoadingWithError:error];
    }
}

@end

NS_ASSUME_NONNULL_END
