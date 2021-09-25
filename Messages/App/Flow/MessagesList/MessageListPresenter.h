//
//  MessageListPresenter.h
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import <Foundation/Foundation.h>
#import "Messages-Swift.h"

NS_ASSUME_NONNULL_BEGIN

//@class MessagesManager;

@protocol MessagesListViewInput
- (void)showNoResults;
- (void)hideNoResults;
- (void)loadingIndicator:(BOOL)isEnabled;
- (void)endRefreshing;
- (void)presentAlert:(NSString*)text;
- (void)showResults:(NSArray*)messagesItemList;
@end

@protocol MessagesListViewOutput
- (void)requestMessages:(BOOL)fromRefreshControl;
@end

@interface MessageListPresenter : NSObject <MessagesListViewOutput>
@property(nonatomic, weak) NSObject<MessagesListViewInput> *viewInput;
- (instancetype) initWith:(MessagesManager*)messageManager;
@end



NS_ASSUME_NONNULL_END
