//
//  UIImage+MY.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(_ imgName: String) {
        self.init(named: imgName)
    }
}
