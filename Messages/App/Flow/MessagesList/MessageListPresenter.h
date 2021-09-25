//
//  MessageListPresenter.h
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MessagesManager;

@protocol MessagesListViewInput
 
-(void)showNoResults;
-(void)hideNoResults;

@end

@protocol MessagesListViewOutput
-(void)requestMessages;
@end

@interface MessageListPresenter : NSObject
@property(nonatomic, weak) NSObject<MessagesListViewInput> *viewInput;
@property(nonatomic, strong) MessagesManager *messagesManager;

-(instancetype) initWith:(MessagesManager*)messageManager;
@end



NS_ASSUME_NONNULL_END
