//
//  JSON+MY.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    var statusCode: Int {
        return self["status"].intValue
    }
    
    var message: String {
        return self["message"].stringValue
    }
    
    var isSuccess: Bool {
        return statusCode == my.code.success
    }
}
