//
//  MYKeychain.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import Foundation

import KeychainAccess

let MYKeychain = MYKeychainClass.shared

extension my {
    struct keychain {
        static let token = "token" + (MYKeychain[my.keychain.mobile] ?? "")
        static let mobile = "mobile"
        static let url = "url"
    }
}

struct MYKeychainClass {
    
    static let shared: Keychain = {
        return Keychain(service: my.net.baseUrl)
            .synchronizable(true)
            .accessibility(.afterFirstUnlock)
    }()
    
}

// MARK: -
extension MYKeychainClass {
    subscript(key: String) -> Any? {
        get {
            return MYKeychainClass.shared[key]
        }
    }
    
    subscript(key: String) -> String? {
        get {
            return (try? MYKeychainClass.shared.get(key)).flatMap { $0 }
        }
        
        set {
            if let value = newValue {
                do {
                    try MYKeychainClass.shared.set(value, key: key)
                } catch {}
            } else {
                do {
                    try MYKeychainClass.shared.remove(key)
                } catch {}
            }
        }
    }
    
    subscript(string key: String) -> String? {
        get {
            return self[key]
        }
        
        set {
            self[key] = newValue
        }
    }
    
    subscript(data key: String) -> Data? {
        get {
            return (try? MYKeychainClass.shared.getData(key)).flatMap { $0 }
        }
        
        set {
            if let value = newValue {
                do {
                    try MYKeychainClass.shared.set(value, key: key)
                } catch {}
            } else {
                do {
                    try MYKeychainClass.shared.remove(key)
                } catch {}
            }
        }
    }
    
    subscript(attributes key: String) -> Attributes? {
        get {
            return (try? MYKeychainClass.shared.get(key) { $0 }).flatMap { $0 }
        }
    }
}
