//
//  SNQueue.m
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "SNQueue.h"

@interface SNQueue()

@property (nonatomic, strong)NSMutableArray *internalQueue;

@end

@implementation SNQueue

@synthesize internalQueue = _internalQueue;

-(id)init{
    self = [super init];
	if(self !=nil){
        self.internalQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) push:(id)item {
    
    [self.internalQueue addObject:item];
}

- (id) pop{
    id item = nil;
    if ([self.internalQueue count] != 0) {
        item = [[[self.internalQueue lastObject] retain] autorelease];
        [self.internalQueue removeLastObject];
    }
    
    return item;
}

- (id) peek{
    id item = nil;
    if ([self.internalQueue count] != 0) {
        item = [self.internalQueue lastObject];
    }
    return item;
}
- (NSUInteger)count{
    return [self.internalQueue count];
}
- (void)dealloc{
    [_internalQueue release];
    [super dealloc];
}

@end
