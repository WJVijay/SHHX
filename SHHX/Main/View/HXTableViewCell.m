//
//  HXTableViewCell.m
//  SHHX
//
//  Created by Yuan Wang on 2018/11/19.
//  Copyright © 2018年 Yuan Wang. All rights reserved.
//

#import "HXTableViewCell.h"

@interface HXTableViewCell()

@property (strong,nonatomic)UILabel                         *contentLabel;

@property (strong,nonatomic)UIImageView                     *iconImageView;

@end
@implementation HXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
    }
    
    return self;
}

- (void)setSting:(NSString *)sting{
    
    sting = sting;
    self.contentLabel.text = sting;
}

- (void)setImgStr:(NSString *)imgStr{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
}

- (void)setUI{
    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.leading.mas_equalTo(self.contentView).mas_offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(80);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(10);
        make.top.mas_offset(90);
        make.leading.mas_equalTo(self.iconImageView.mas_trailing).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    }];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
  
}

- (UILabel *)contentLabel{
    
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 1;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:18.0];
        _contentLabel.backgroundColor = [UIColor blackColor];
    }
    return _contentLabel;
}

- (UIImageView *)iconImageView{
    
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

@end
