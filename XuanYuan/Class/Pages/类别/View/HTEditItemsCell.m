//
//  HTEditItemsCell.m
//  XuanYuan
//
//  Created by King on 2017/4/26.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTEditItemsCell.h"

@implementation HTEditItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textField.delegate = self;
    self.textField.borderActiveColor = MainRGB;
    self.textField.borderInactiveColor = MainTextColor;
    self.textField.placeholderFontScale = 1.0;
    self.textField.placeholderColor = MainTextColor;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)setModel:(HTEditItemsModel *)model
{
    _model = model;
    self.titleL.text = _model.title;
    self.textField.text = model.text;
    self.textField.placeholder = _model.titlePlaceholder;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.textField) {
        
        if ((range.length == 1 && string.length == 0)||[self.model.title isEqualToString:@"备注"]) {
            return YES;
        }
        else if (self.textField.text.length >= 15) {
            
            self.textField.text = [textField.text substringToIndex:15];
            return NO;
        }
    }
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.text = textField.text;

    if (self.didEndEditing) {
        self.didEndEditing(textField.text,self.model.index,self.model);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
