//
//  ZZTestCell.m
//  Demo
//
//  Created by 刘威振 on 7/5/16.
//  Copyright © 2016 刘威振. All rights reserved.
//

#import "ZZTestCell.h"

@implementation ZZTestCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor       = [UIColor whiteColor];
        _imageView                 = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode     = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];

        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        _deleteBtn.layer.cornerRadius = 20;
        _deleteBtn.layer.masksToBounds = YES;
        [self addSubview:_deleteBtn];
        self.clipsToBounds         = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _deleteBtn.frame = CGRectMake(self.bounds.size.width - 40, 0, 40, 40);
}

@end
