//
//  String+Extension.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/31.
//

import UIKit


extension String {
    
    func toImage(completionHandler: @escaping (UIImage) -> Void) {
        guard let url = URL(string: self) else { return }
               
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    completionHandler(image)
                }
            }
        }
    }
    
}
