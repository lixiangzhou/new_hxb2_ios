//
//  MYTabBarController.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class MYTabBarController: UITabBarController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildControllers()
        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension MYTabBarController {
    fileprivate func addChildControllers() {
        add(childController: MYHomeController(), title: "首页", imageName: "tabbar_home")
        add(childController: MYMineController(), title: "我的", imageName: "tabbar_mine")
    }
    
    fileprivate func setUI() {
        view.backgroundColor = UIColor.white
    }
    
    private func add(childController: MYViewController, title: String, imageName: String) {
        childController.title = title
        
//        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: my.color.theme], for: .selected)
//        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: my.color.normal], for: .normal)
//
//        childController.tabBarItem.image = UIImage(imageName)?.withRenderingMode(.alwaysOriginal)
//        childController.tabBarItem.selectedImage = UIImage(imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        let navVC = MYNavigationController(rootViewController: childController)
        addChildViewController(navVC)
    }
}

// MARK: - Action
extension MYTabBarController {
    
}

// MARK: - Network
extension MYTabBarController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension MYTabBarController {
    
}

// MARK: - Other
extension MYTabBarController {
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        MYShakeConfigUrlView.show()
    }
}

// MARK: - Public
extension MYTabBarController {
    
}

