//
//  JANSettingViewController.m
//  QiitaMeter
//
//  Created by 神田 on 2015/03/15.
//  Copyright (c) 2015年 bob. All rights reserved.
//

#import "JANSettingViewController.h"
#import "JANDataService.h"

@interface JANSettingViewController ()<UITableViewDataSource, UITableViewDelegate, JANDataServiceViewUpdateObserver>

@end

@implementation JANSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _count = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %ld", (long)indexPath.section, (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _count--;
        [self.userTableView beginUpdates];
        [self.userTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.userTableView endUpdates];
    }
}

#pragma -
- (IBAction)logOut:(id)sender {
    [JANDataService setViewUpdateToObserver:self];
    [JANDataService logoutRequest:nil];
}

- (void)updateViewWithLogout:(NSNotification *)dic
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addUser:(id)sender {
    [self addUserAlert];
}

- (IBAction)editMode:(UIButton *)sender {
    if (self.userTableView.editing) {
        [self.userTableView setEditing:NO animated:YES];
        [sender setTitle:@"Edit Mode" forState:UIControlStateNormal];
    } else {
        [self.userTableView setEditing:YES animated:YES];
        [sender setTitle:@"Cancel" forState:UIControlStateNormal];
    }
}

#pragma -
- (void)addUserAlert{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"比較ユーザーを追加"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Add", nil];
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];//１行で実装
    UITextField *textField = [message textFieldAtIndex:0];
    textField.placeholder = @"Qiita ID";
    [message show];
}
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    if( [inputText length] >= 1 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        _count++;
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:_count-1 inSection:0];
        [self.userTableView beginUpdates];
        [self.userTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.userTableView endUpdates];
    }
}
@end
