//
//  BioTableViewCell.h
//  dota2
//
//  Created by inowei on 12/8/15.
//  Copyright © 2015 inowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BioTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *heroIcon;
@property (weak, nonatomic) IBOutlet UILabel *heroName;
@property (weak, nonatomic) IBOutlet UILabel *heroType;

@end
