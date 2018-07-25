//
//  MYSignal.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

import ReactiveSwift
import Result

let (loginSignal, loginObserver) = Signal<[String: AnyObject]?, NoError>.pipe()
