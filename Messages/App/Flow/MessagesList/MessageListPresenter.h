//
//  MessageListPresenter.h
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MessagesListViewInput

-(void)showNoResults;
-(void)hideNoResults;

@end

@protocol MessagesListViewOutput

-(void)requestMessages;

@end

@interface MessageListPresenter : NSObject

@end

NS_ASSUME_NONNULL_END
