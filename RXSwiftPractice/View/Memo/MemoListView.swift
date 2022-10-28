//
//  MemoListView.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/28.
//

import UIKit

import SnapKit
import Then


final class MemoListView: BaseView {
    
    // MARK: - Propertys
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: .listLayout()).then {
        $0.backgroundColor = .systemBackground
    }
    
    
    
    
    // MARK: - Methods
    override func configureUI() {
        self.backgroundColor = .systemBackground
        self.addSubview(collectionView)
    }
    
    
    override func setConstraint() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
