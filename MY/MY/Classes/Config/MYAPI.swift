//
//  MYAPI.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

extension my {
    struct api {
        /// 获取token
        static let token = "/token"
        
        /// 首页
        static let home = "/home"
        
        /// 登录用户获取用户信息和用户资产等信息
        static let account_info = "/user/info"
        
        /// 帐户中心首页,包含用户资产，可用优惠券数量，是否可邀请
        static let account = "/account"
    }
}
