//
//  MYNetActivityManager.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class MYNetActivityManager {
    static let shared = MYNetActivityManager()
    
    private let requestCount = MutableProperty(0)
    private var lock = NSLock()
    
    private init() {
        UIApplication.shared.reactive.makeBindingTarget { $0.isNetworkActivityIndicatorVisible = $1 } <~ requestCount.signal.map { $0 > 0 }
    }
    
    func sendRequest() {
        safeCount {
            requestCount.value += 1
        }
    }
    
    func finishRequest() {
        safeCount {
            requestCount.value -= 1
        }
    }
    
    private func safeCount(_ count: () -> Void) {
        lock.lock()
        count()
        lock.unlock()
    }
    
    static func sendRequest() {
        MYNetActivityManager.shared.sendRequest()
    }
    
    static func finishRequest() {
        MYNetActivityManager.shared.finishRequest()
    }
    
}
