//
//  UITableViewCell+ShareCell.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/25.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "UITableViewCell+ShareCell.h"

@implementation UITableViewCell (ShareCell)

+(id)shareCellTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self shareCellTableView:tableView style:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

+(id)shareCellTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    UITableViewCell *cell = (UITableViewCell *)[self class];
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:style reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = kSystemFitFont(16);
        cell.textLabel.textColor = RGB_COLOR_WITH_0x(kBlackTextColor);
        cell.detailTextLabel.font = kSystemFitFont(16);
    }
    return cell;
}
@end
