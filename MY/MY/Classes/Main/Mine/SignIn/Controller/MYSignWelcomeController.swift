//
//  MYSignWelcomeController.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit

class MYSignWelcomeController: MYViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Public Property
    
    // MARK: - Private Property
    
}

// MARK: - UI
extension MYSignWelcomeController {
    fileprivate func setUI() {
        let welcomeLabel = UILabel(text: "欢迎来到红小宝", font: my.font.f30, textColor: my.color.hex505050)
        view.addSubview(welcomeLabel)
        
        let mobileField = UITextField()
        mobileField.font = my.font.f15
        mobileField.textColor = my.color.hex555555
        mobileField.clearButtonMode = .whileEditing
        mobileField.placeholder = "请输入手机号"
        mobileField.keyboardType = .numberPad
        mobileField.delegate = self
        view.addSubview(mobileField)
        
        let line = UIView()
        line.backgroundColor = my.color.hexF5F5F9
        view.addSubview(line)
        
        let nextBtn = UIButton(title: "下一步", font: my.font.f16, titleColor: UIColor.white, target: self, action: #selector(nextAction))
        nextBtn.backgroundColor = my.color.hexFF7055
        nextBtn.layer.cornerRadius = 4
        nextBtn.clipsToBounds = true
        nextBtn.adjustsImageWhenHighlighted = false
        view.addSubview(nextBtn)
        
        let logoView = UIImageView(named: "logo_gray")
        let bankView = UIImageView(named: "bank_hf_gray")
        logoView.contentMode = .scaleAspectFit
        bankView.contentMode = .scaleAspectFit
        
        let sepLine = UIView()
        sepLine.backgroundColor = my.color.hexD8D8D8
        
        let descLabel = UILabel(text: "已接入恒丰银行资金存管", font: my.font.f12, textColor: my.color.hexCBCBCB)
        
        view.addSubview(logoView)
        view.addSubview(bankView)
        view.addSubview(sepLine)
        view.addSubview(descLabel)
        
        
        welcomeLabel.snp.makeConstraints { maker in
            maker.top.equalTo(30)
            maker.left.equalTo(25)
        }
        
        mobileField.snp.makeConstraints { maker in
            maker.top.equalTo(welcomeLabel.snp.bottom).offset(60)
            maker.left.equalTo(welcomeLabel)
            maker.right.equalTo(-25)
            maker.height.equalTo(35);
        }
        
        line.snp.makeConstraints { maker in
            maker.bottom.left.right.equalTo(mobileField)
            maker.height.equalTo(1)
        }
        
        nextBtn.snp.makeConstraints { maker in
            maker.left.right.equalTo(mobileField)
            maker.height.equalTo(41)
            maker.top.equalTo(mobileField.snp.bottom).offset(60)
        }
        
        descLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(-30)
            maker.centerX.equalTo(view)
        }
        
        logoView.snp.makeConstraints { maker in
            maker.right.equalTo(sepLine.snp.left).offset(-7)
            maker.bottom.equalTo(descLabel.snp.top).offset(-8)
            maker.size.equalTo(CGSize(width: 65, height: 18))
        }
        
        sepLine.snp.makeConstraints { maker in
            maker.height.equalTo(18)
            maker.width.equalTo(1)
            maker.centerX.equalTo(view)
            maker.centerY.equalTo(logoView)
        }
        
        bankView.snp.makeConstraints { maker in
            maker.bottom.centerY.equalTo(logoView)
            maker.left.equalTo(sepLine.snp.right).offset(7)
            maker.size.equalTo(CGSize(width: 73, height: 18))
        }
    }
}

// MARK: - Action
extension MYSignWelcomeController {
    @objc fileprivate func nextAction() {
        
    }
}

// MARK: - Network
extension MYSignWelcomeController {
    
}

// MARK: - Delegate Internal

// MARK: - UITextFieldDelegate
extension MYSignWelcomeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count >= 1 {
            return range.location < 11
        } else {
            return true
        }
    }
}

