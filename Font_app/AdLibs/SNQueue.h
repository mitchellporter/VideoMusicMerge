//
//  SNQueue.h
//  forever
//
//  Created by forever on 31/08/13.
//  Copyright (c) 2013 GS. All rights reserved.
//
//

/*
 * Custom Objective C Implementation of Queue Data Structure
 * For more information Visit the wiki page below.
 * http://en.wikipedia.org/wiki/Queue_(data_structure)
 *
 */

#import <Foundation/Foundation.h>


/**
 Composition is choosen over inheritance or Categories
 NSMutableArray is used an internal data structure
 */
@interface SNQueue : NSObject




/**
 Public methods
 */
- (void)push:(id)item;
- (id) pop;
- (id) peek;
- (NSUInteger)count;

@end
