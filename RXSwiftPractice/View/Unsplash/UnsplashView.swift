//
//  UnsplashView.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import UIKit

import SnapKit
import Then


final class UnsplashView: BaseView {
    
    // MARK: - Propertys
    let searchBar = UISearchBar().then {
        $0.backgroundColor = .lightGray
        $0.placeholder = "사진 검색"
    }
    
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: .listLayout())
    
    
    
    
    // MARK: - Methods
    override func configureUI() {
        [searchBar, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    
    override func setConstraint() {
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.horizontalEdges.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
