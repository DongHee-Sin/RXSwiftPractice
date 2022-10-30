//
//  UIViewController+Extension.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import UIKit


extension UIViewController {
    
    enum TransitionStyle {
        case present
        case push
    }
    
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
