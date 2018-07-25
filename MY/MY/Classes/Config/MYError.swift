//
//  MYError.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

enum MYError: Error {
    case requestUrlNil
    case encodingFailed(error: Error)
}
