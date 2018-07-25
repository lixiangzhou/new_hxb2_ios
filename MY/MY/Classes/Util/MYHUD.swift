//
//  MYHUD.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import XZLib

enum MYHudContainerType {
    case window     /// 显示在window上
    case view       /// 显示在view上
    case none       /// 不显示
}

protocol MYHUDShowDelegate: NSObjectProtocol {
    func showProgress(type: MYHudContainerType)
    func hideProgress(type: MYHudContainerType)
    func show(toast: String, type: MYHudContainerType)
}

struct MYHUD {
    static func show(toast: String, in view: UIView = UIApplication.shared.keyWindow!) {
        ZZHud.show(message: toast,
                   font: my.font.f12,
                   color: UIColor.white,
                   backgroundColor: my.color.hudBackground,
                   cornerRadius: my.length.hudCornerRadius,
                   showDuration: 1,
                   toView: view)
    }
    
    static func showLoding(toView: UIView) {
        let loadingBgView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.startAnimating()
        
        loadingBgView.addSubview(activityView)
        activityView.center = loadingBgView.center
        
        ZZHud.show(loading: loadingBgView,
                   loadingId: NSNotFound,
                   toView: toView,
                   hudCornerRadius: my.length.hudCornerRadius,
                   hudBackgroundColor: my.color.hudBackground,
                   hudAlpha: 1,
                   contentInset: UIEdgeInsetsMake(0, 0, 0, 0),
                   position: .center,
                   offsetY: 0,
                   animation: nil)
    }
    
    static func hideLoding(forView: UIView) {
        ZZHud.hideLoading(for: forView)
    }
}
