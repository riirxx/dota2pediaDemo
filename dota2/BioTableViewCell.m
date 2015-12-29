//
//  BioTableViewCell.m
//  dota2
//
//  Created by inowei on 12/8/15.
//  Copyright © 2015 inowei. All rights reserved.
//

#import "BioTableViewCell.h"

@implementation BioTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
