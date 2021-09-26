//
//  MessageListTableViewCell.m
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import "MessageListTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface MessageListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation MessageListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureImageView];
}

- (void) configureImageView {
    self.imageView.layer.cornerRadius = 22;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) configureWithModel:(MessageItem*)messageItem {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:messageItem.user.avatarUrl]
                            placeholderImage:[UIImage imageNamed:@"userImagePlaceholder"]];
    self.usernameLabel.text = messageItem.user.nickname;
    self.messageLabel.text = messageItem.message.text;
    [self.messageLabel sizeToFit];
    self.dateLabel.text = [self formatDate:messageItem.message.receivedAt];
}

- (NSString*) formatDate:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    if (isToday) {
        [dateFormatter setDateFormat:@"HH:mm"];
        
        return [dateFormatter stringFromDate:date];
    }
    
    BOOL isYesterday = [[NSCalendar currentCalendar] isDateInYesterday:date];
    if (isYesterday) {
        return @"Yesterday";
    }
    
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    return [dateFormatter stringFromDate:date];
}

@end
