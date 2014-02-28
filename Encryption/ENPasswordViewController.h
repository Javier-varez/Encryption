//
//  ENPasswordViewController.h
//  Encryption
//
//  Created by Francisco Javier Álvarez García on 26/01/14.
//  Copyright (c) 2014 Francisco Javier Álvarez García. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)textFieldUpdated:(id)sender;

@end