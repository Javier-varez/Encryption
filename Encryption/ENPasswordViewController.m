//
//  ENPasswordViewController.m
//  Encryption
//
//  Created by Francisco Javier Álvarez García on 26/01/14.
//  Copyright (c) 2014 Francisco Javier Álvarez García. All rights reserved.
//

#import "ENPasswordViewController.h"
#import "NSString+Encryption.h"

@interface ENPasswordViewController () {
    NSString *_Password;
}

@end

@implementation ENPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /*NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/password.txt"];
    
    NSError *err;
    
    _Password = [NSString stringWithContentsOfFile:path encoding:NSStringEncodingConversionAllowLossy error:&err];*/
    
    _Password = [[NSUserDefaults standardUserDefaults] objectForKey:@"Password_Encryption"];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.textField becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldUpdated:(id)sender {
    NSString *hash =[self.textField.text hashEncryption];
    if ([_Password isEqualToString:hash] || _Password == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
