//
//  UILabel+MY.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont, textColor: UIColor, numOfLines: Int = 0, textAlignment: NSTextAlignment = .left) {
        self.init()
        
        self.font = font
        self.textColor = textColor
        self.text = text
        self.numberOfLines = numOfLines
        self.textAlignment = textAlignment
        
        sizeToFit()
    }
}
