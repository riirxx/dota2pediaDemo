//
//  AbilityCell.h
//  dota2
//
//  Created by inowei on 12/28/15.
//  Copyright © 2015 inowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbilityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *abilityImageView;
@property (weak, nonatomic) IBOutlet UILabel *abilityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitydetailLabel;

@end
