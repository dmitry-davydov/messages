//
//  MessageListPresenter.m
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import "MessageListPresenter.h"


@interface MessageListPresenter () <MessagesListViewOutput>

@property(nonatomic, strong) MessagesManager *messageManager;

@end


@implementation MessageListPresenter
-(instancetype)initWith:(MessagesManager *)messageManager {
    self = [super init];
    if (self) {
        self.messageManager = messageManager;
    }
    
    return self;
}

// MARK: - MessagesListViewOutput
- (void)requestMessages:(BOOL)fromRefreshControl {
    
    if (!fromRefreshControl) {
        [self.viewInput loadingIndicator:true];
    }
    
    [self.messageManager fetchListOn:^(NSArray<MessageItem *> * _Nonnull data) {
        
        if (!fromRefreshControl) {
            [self.viewInput loadingIndicator:false];
        }
        
        if (fromRefreshControl) {
            [self.viewInput endRefreshing];
        }
        
        if ([data count] == 0) {
            [self.viewInput showNoResults];
            return ;
        }
        [self.viewInput hideNoResults];
        [self.viewInput showResults:data];
        
    } onError:^(enum NetworkErrorWrapper error) {
        
        if (!fromRefreshControl) {
            [self.viewInput loadingIndicator:false];
        }
        
        if (fromRefreshControl) {
            [self.viewInput endRefreshing];
        }
        switch (error) {
            case NetworkErrorWrapperUnknown:
            case NetworkErrorWrapperResponseSerialization:
                [self.viewInput presentAlert:@"Unknown error. Please try later"];
                break;
            case NetworkErrorWrapperNoInternetConnection:
                [self.viewInput presentAlert:@"No internet connection"];
                break;
            case NetworkErrorWrapperTimeout:
                [self.viewInput presentAlert:@"No connection to server. Please, try again later"];
                break;
        }
    }];
}

@end


