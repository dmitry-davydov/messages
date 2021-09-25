//
//  ViewController.h
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import <UIKit/UIKit.h>
#import "MessageListPresenter.h"

@interface MessageListViewController : UIViewController <MessagesListViewInput>

@property(nonatomic,strong) MessageListPresenter *presenter;

-(instancetype) initWithPresenter:(MessageListPresenter*)presenter;

@end

