//
//  UIImageView+MY.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(named: String) {
        self.init(image: UIImage(named))
    }
}
