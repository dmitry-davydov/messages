//
//  MessageListViewController.m
//  Messages
//
//  Created by Дима Давыдов on 25.09.2021.
//

#import "MessageListViewController.h"
#import "MessageListTableViewCell.h"

@interface MessageListViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *messagesList;

@property(nonatomic,strong) UILabel *noResultsView;
@property(nonatomic,strong) UIActivityIndicatorView *loadingIndicator;
@property(nonatomic,strong) UIAlertController *loadingAlertViewController;

@end

@implementation MessageListViewController

- (instancetype) initWithPresenter:(MessageListPresenter *)presenter {
    self = [super init];
    if (self) {
        self.presenter = presenter;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
    [self.presenter requestMessages:false];
}

- (void) configureViews {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"MessageListTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(onUpdateWithRefreshControl) forControlEvents: UIControlEventValueChanged];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(15, 0, 0, 0)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self configureNoResultsView];
    [self configureLoader];
}

- (void) configureNoResultsView {
    
    UILabel* view = [[UILabel alloc] init];
    
    [view setText:@"Nothing found"];
    
    [self.tableView addSubview:view];
    
    [[view.centerYAnchor constraintEqualToAnchor:self.tableView.centerYAnchor] setActive:YES];
    [[view.centerXAnchor constraintEqualToAnchor:self.tableView.centerXAnchor] setActive:YES];
    
    self.noResultsView = view;
}

- (void) configureLoader {
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    self.loadingIndicator.hidesWhenStopped = YES;
    self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
    
    self.loadingAlertViewController = [UIAlertController
                                       alertControllerWithTitle:@"Plase wait"
                                       message:nil
                                       preferredStyle:UIAlertControllerStyleAlert];
    
    [self.loadingAlertViewController.view addSubview:self.loadingIndicator];
}

// MARK: - MessagesListViewInput
- (void)hideNoResults {
    self.noResultsView.hidden = YES;
}

- (void)showNoResults {
    self.noResultsView.hidden = NO;
}

- (void)loadingIndicator:(BOOL)isEnabled {
    
    if (isEnabled) {
        [self.loadingIndicator startAnimating];
        [self presentViewController:self.loadingAlertViewController animated:YES completion:nil];
        
        return ;
    }
    
    [self.loadingIndicator stopAnimating];
    [self.loadingAlertViewController dismissViewControllerAnimated:true completion:nil];
}

- (void)presentAlert:(nonnull NSString *)text {
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:text
                                message:nil
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction
                                    actionWithTitle:@"Close"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showResults:(nonnull NSArray *)messagesItemList {
    self.messagesList = messagesItemList;
    [self.tableView reloadData];
}

- (void)endRefreshing {
    [self.tableView.refreshControl endRefreshing];
}


//MARK: - UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageListTableViewCell *cell = (MessageListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MessageListTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    MessageItem *messageItemModel = self.messagesList[indexPath.row];
    if (!messageItemModel) {
        return cell;
    }
    
    [cell configureWithModel:messageItemModel];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messagesList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}

// MARK: Actions
- (void) onUpdateWithRefreshControl {
    [self.presenter requestMessages:true];
}

@end
