//
//  MessageListTableViewCell.h
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import <UIKit/UIKit.h>
#import "Messages-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListTableViewCell : UITableViewCell
- (void) configureWithModel:(MessageItem*)messageItem;
@end

NS_ASSUME_NONNULL_END
