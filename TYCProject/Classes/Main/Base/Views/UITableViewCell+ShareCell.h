//
//  UITableViewCell+ShareCell.h
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/25.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (ShareCell)

+(id)shareCellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;
+(id)shareCellTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
