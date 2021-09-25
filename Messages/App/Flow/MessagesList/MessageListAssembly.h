//
//  MessageListAssembly.h
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import <Foundation/Foundation.h>
#import "MessageListViewController.h"
#import "MessageListPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListAssembly : NSObject
+ (MessageListViewController *)assembly;
@end

NS_ASSUME_NONNULL_END
