//
//  MYShakeConfigUrlView.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class MYShakeConfigUrlView: UIView {
    
    static let animateDuration: TimeInterval = 0.5
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Property
    
    // MARK: - Private Property
    fileprivate let fieldView = UITextField()
    fileprivate let button = UIButton(title: "确定", font: my.font.f16, titleColor: UIColor.white, backgroundColor: UIColor.orange)
}

// MARK: - UI
extension MYShakeConfigUrlView {
    fileprivate func setUI() {
        backgroundColor = UIColor.white
        fieldView.placeholder = "请输入url, 例如:\(my.net.baseUrl)"
        fieldView.font = my.font.f15
        fieldView.borderStyle = .roundedRect
        fieldView.text = my.net.baseUrl
        button.reactive.controlEvents(.touchUpInside).observeValues { [weak self, weak fieldView] _ in
            let url = fieldView?.text ?? ""
            self?.saveUrl(url: url)
            self?.alpha = 1
            UIView.animate(withDuration: MYShakeConfigUrlView.animateDuration, animations: {
                self?.alpha = 0
            }, completion: { (_) in
                self?.removeFromSuperview()
            })
        }
        
        addSubview(fieldView)
        addSubview(button)
        
        fieldView.snp.makeConstraints { maker in
            maker.top.equalTo(150)
            maker.width.equalTo(250)
            maker.height.equalTo(30)
            maker.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { maker in
            maker.top.equalTo(fieldView.snp.bottom).offset(20)
            maker.width.equalTo(120)
            maker.height.equalTo(35)
            maker.centerX.equalToSuperview()
        }
    }
}

// MARK: - Helper
extension MYShakeConfigUrlView {
    @discardableResult
    fileprivate func saveUrl(url: String) -> Bool {
        do {
            try url.write(toFile: my.string.urlStorePath, atomically: true, encoding: .utf8)
            my.net.baseUrl = url
            MYKeychain[my.keychain.url] = url
            return true
        } catch {
            return false
        }
    }
}

// MARK: - Public
extension MYShakeConfigUrlView {
    static func show() {
        let shakeConfigUrlView = MYShakeConfigUrlView()
        shakeConfigUrlView.frame = UIScreen.main.bounds
        shakeConfigUrlView.alpha = 0
        UIApplication.shared.keyWindow!.addSubview(shakeConfigUrlView)
        UIView.animate(withDuration: MYShakeConfigUrlView.animateDuration, animations: {
            shakeConfigUrlView.alpha = 1
        })
    }
}
