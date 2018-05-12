//
//  CustomCell.m
//  codeChallenge
//
//  Created by Nano Suarez on 18/04/2018.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cellContinerView.layer.cornerRadius = 8;
    self.cellContinerView.layer.masksToBounds = true;
    self.cellContinerView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cellContinerView.layer.borderWidth = 1;
    self.imageCell.layer.cornerRadius = 35;
    self.imageCell.layer.masksToBounds = true;
    self.imageCell.backgroundColor = [UIColor grayColor];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageCell.image = nil;
}

- (void) setUpCellWith :(PhotoModel *)photo {
    self.imageTitleCell.text = photo.title;
    self.imageSubtitleCell.attributedText = photo.descriptionRenderedText ;
    [self.imageCell downloadImageFromLink:photo.url contentMode:UIViewContentModeCenter];
}

@end
