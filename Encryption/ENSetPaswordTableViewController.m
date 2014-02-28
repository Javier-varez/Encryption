//
//  ENSetPaswordTableViewController.m
//  Encryption
//
//  Created by Francisco Javier Álvarez García on 27/01/14.
//  Copyright (c) 2014 Francisco Javier Álvarez García. All rights reserved.
//

#import "ENSetPaswordTableViewController.h"
#import "ENPasswordCell.h"
#import "NSString+Encryption.h"

@interface ENSetPaswordTableViewController ()

@end

@implementation ENSetPaswordTableViewController {
    NSString *_Password;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillBeDismissed) name:UIApplicationWillResignActiveNotification object:nil];
    
    /*NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/password.txt"];
    
    NSError *err;
    
    _Password = [NSString stringWithContentsOfFile:path encoding:NSStringEncodingConversionAllowLossy error:&err];*/
    
    _Password = [[NSUserDefaults standardUserDefaults] objectForKey:@"Password_Encryption"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnTableView)];
    [self.tableView addGestureRecognizer:tap];
}

-(void)viewWillBeDismissed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) tapOnTableView {
    ENPasswordCell *currentPassCell = (ENPasswordCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ENPasswordCell *newPassCell1 = (ENPasswordCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ENPasswordCell *newPassCell2 = (ENPasswordCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    [currentPassCell.textField resignFirstResponder];
    [newPassCell1.textField resignFirstResponder];
    [newPassCell2.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) return 1;
    else return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"passwordCell";
    ENPasswordCell *cell = (ENPasswordCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) cell.textField.placeholder = @"Enter new password";
        else cell.textField.placeholder = @"in both cells";
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Enter Current Password";
    else return @"Enter new password";
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (IBAction)returnButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)updateButtonPressed:(id)sender {
    ENPasswordCell *currentPassCell = (ENPasswordCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ENPasswordCell *newPassCell1 = (ENPasswordCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ENPasswordCell *newPassCell2 = (ENPasswordCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    if (![[currentPassCell.textField.text hashEncryption] isEqualToString:_Password] && _Password != nil) {
        [self.tableView selectRowAtIndexPath:[self.tableView indexPathForCell:currentPassCell] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    else if (![newPassCell1.textField.text isEqualToString:newPassCell2.textField.text]) {
        [self.tableView selectRowAtIndexPath:[self.tableView indexPathForCell:newPassCell1] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    if(([[currentPassCell.textField.text hashEncryption] isEqualToString:_Password] || _Password == nil) && [newPassCell1.textField.text isEqualToString:newPassCell2.textField.text]) {
        NSString *string = newPassCell2.textField.text;
        
        /*NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/password.txt"];
        
        NSError *err;
        
        
        
        [string writeToFile:path atomically:YES encoding:NSStringEncodingConversionAllowLossy error:&err];*/
        
        NSString *hashedString = [string hashEncryption];
        
        [[NSUserDefaults standardUserDefaults] setObject:hashedString forKey:@"Password_Encryption"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
