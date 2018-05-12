//
//  CustomCell.h
//  codeChallenge
//
//  Created by Nano Suarez on 18/04/2018.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

@import UIKit;
#import "codeChallenge-Swift.h"

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageCell;
@property (weak, nonatomic) IBOutlet UILabel *imageTitleCell;
@property (weak, nonatomic) IBOutlet UILabel *imageSubtitleCell;
@property (weak, nonatomic) IBOutlet UIView *cellContinerView;

- (void) setUpCellWith :(PhotoModel *)photo;

@end
