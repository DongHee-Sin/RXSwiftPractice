//
//  APIManager.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import Foundation

import Alamofire
import RxAlamofire
import RxSwift


typealias SearchPhotoHandler = (SearchPhoto) -> Void


final class APIManager {
    
    private init() {}
    
    static func searchPhoto(_ bag: DisposeBag, query: String, completion: @escaping SearchPhotoHandler) {
        
        let url = APIKeys.baseURL + query
        let header: HTTPHeaders = ["Authorization": APIKeys.authorization]
        
        request(.get, url, headers: header)
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe { value in
                completion(value)
            }
            .disposed(by: bag)
    }
}
