//
//  MemoListView.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/28.
//

import UIKit
import SnapKit


final class MemoListView: BaseView {
    
    // MARK: - Propertys
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: .listLayout())
    
    
    
    
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
