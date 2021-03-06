//
//  MYViewController.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class MYViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /// 单独的隐藏导航栏
    var hideNavigationBar = false
    
    var isInnerVC = false
    
    /// 返回按钮的样式
    var backItemStyle: MYNavBackItemImageStyle = .gray {
        didSet {
            if isInnerVC {
                return
            }
            
            let img: UIImage!
            switch backItemStyle {
            case .gray:
                img = UIImage("nav_back_gray")
            case .white:
                img = UIImage("nav_back_white")
            case .none:
                img = nil
            }
            
            if let img = img {
                let backItem = UIBarButtonItem(image: img.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
                navigationItem.leftBarButtonItem = backItem
            } else {
                navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    /// 导航栏的背景样式
    var navigationBarBackgroundStyle: MYNavigationBarBackgroundStyle = .white {
        didSet {
            if isInnerVC {
                return
            }
            switch navigationBarBackgroundStyle {
            case .white:
                navigationController?.navigationBar.setBackgroundImage(UIImage.zz_image(withColor: .white, imageSize: 1), for: .default)
                navigationController?.navigationBar.shadowImage = UIImage()
            case .clear:
                hideNavigationBar = true
                navigationController?.setNavigationBarHidden(hideNavigationBar, animated: true)
            case .gradientRed:
                
                let navImg = UIImage.zz_gradientImage(fromColor: UIColor(stringHexValue: "ff3b2d")!,
                                                      toColor: UIColor(stringHexValue: "ff6c2f")!,
                                                      size: CGSize(width: UIScreen.zz_width, height: my.length.navigationHeight))
                navigationController?.navigationBar.setBackgroundImage(navImg, for: .default)
                navigationController?.navigationBar.shadowImage = UIImage()
            case .normal:
                navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                navigationController?.navigationBar.shadowImage = nil
            }
            
        }
    }
    
}

// MARK: - UI
extension MYViewController {
    fileprivate func setUI() {
        view.backgroundColor = UIColor.white
        backItemStyle = .gray
        navigationBarBackgroundStyle = .white
    }
}

// MARK: - Action
extension MYViewController {
    @objc fileprivate func back() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Network
extension MYViewController {
    
}

// MARK: - Delegate Internal

// MARK: -

// MARK: - Delegate External

// MARK: -

// MARK: - Helper
extension MYViewController {
    
}

// MARK: - Other
extension MYViewController: MYReactiveProtocol {
    enum MYNavBackItemImageStyle {
        case white
        case gray
        case none
    }
    
    enum MYNavigationBarBackgroundStyle {
        case white
        case gradientRed
        case clear
        case normal
    }
    
    @objc func reactive_bind() { }
}

// MARK: - Public
extension MYViewController {
    
}

