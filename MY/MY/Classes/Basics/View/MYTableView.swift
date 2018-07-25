//
//  MYTableView.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

enum MYFooterRefreshType {
    case nomoreData
    case moreData
    case none
}

class MYTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
    }
    
    convenience init(frame: CGRect = .zero, style: UITableViewStyle = .grouped, dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?) {
        self.init(frame: frame, style: style)
        self.dataSource = dataSource
        self.delegate = delegate
        separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
