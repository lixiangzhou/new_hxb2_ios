//
//  MYHomeController.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class MYHomeController: MYViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension MYHomeController {
    fileprivate func setUI() {
        let btn1 = UIButton(title: "登录", font: my.font.f14, target: self, action: #selector(signIn))
        btn1.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        view.addSubview(btn1)
        
        
        let btn2 = UIButton(title: "注册", font: my.font.f14, target: self, action: #selector(signUp))
        btn2.frame = CGRect(x: 80, y: 0, width: 60, height: 30)
        view.addSubview(btn2)
        
    }
}

// MARK: - Action
extension MYHomeController {
    @objc func signIn() {
        present(MYNavigationController(rootViewController: MYSignWelcomeController()), animated: true, completion: nil)
    }
    
    @objc func signUp() {
        
    }
}

// MARK: - Network
extension MYHomeController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension MYHomeController {
    
}

// MARK: - Other
extension MYHomeController {
    
}

// MARK: - Public
extension MYHomeController {
    
}

