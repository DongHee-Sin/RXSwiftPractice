//
//  WriteMemoView.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/29.
//

import UIKit

import SnapKit
import Then


final class WriteMemoView: BaseView {
    
    // MARK: - Propertys
    let textView = UITextView().then {
        $0.textColor = .label
    }
    
    
    
    
    // MARK: - Methods
    override func configureUI() {
        self.addSubview(textView)
    }
    
    
    override func setConstraint() {
        textView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
