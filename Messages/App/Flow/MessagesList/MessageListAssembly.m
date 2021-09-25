//
//  MessagesListAssembly.m
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import "MessageListAssembly.h"

@implementation MessageListAssembly
+ (MessageListViewController*) assembly {
    MessageListViewController* vc = [[MessageListViewController alloc] init];
    vc.title = @"Messages";
    
    MessagesManager* messagesManager = [[MessagesManager alloc]init];
    MessageListPresenter* presenter = [[MessageListPresenter alloc] initWith:messagesManager];
    
    presenter.viewInput = vc;
    vc.presenter = presenter;
    
    return vc;
}
@end
