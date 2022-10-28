//
//  UICollectionViewLayout+Extension.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/28.
//

import UIKit


extension UICollectionViewLayout {
    
    static func listLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
}
