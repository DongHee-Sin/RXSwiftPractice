//
//  APIManager.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import Foundation
import Alamofire


final class APIManager {
    
    private init() {}
    
    typealias SearchPhotoHandler = (SearchPhoto?, Int?, Error?) -> Void
    
    
    static func searchPhoto(query: String, completion: @escaping SearchPhotoHandler) {
        
        let url = APIKeys.baseURL + query
        let header: HTTPHeaders = ["Authorization": APIKeys.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhoto.self) { response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value):
                completion(value, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
            
        }
        
    }
}
