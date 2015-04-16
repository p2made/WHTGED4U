//
//  P2DataSynchroniser.h
//  WHTGED4U
//
//  Created by Pedro Plowman on 16/08/13.
//  Copyright (c) 2013 Pedro Plowman. All rights reserved.
//

@protocol P2DataSynchroniserDelegate;

@interface P2DataSynchroniser : NSObject

- (instancetype)initWithDelegate:(id<P2DataSynchroniserDelegate>)delegate usingHUD:(BOOL)usingHUD;
- (void)synchronise;

@end

@protocol P2DataSynchroniserDelegate <NSObject>

- (void)synchronisationFailed;
- (void)synchronisationCompleted;

@end
