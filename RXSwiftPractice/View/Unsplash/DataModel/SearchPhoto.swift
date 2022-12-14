//
//  SearchPhoto.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/31.
//

import Foundation


struct SearchPhoto: Codable, Hashable {
    let total, totalPages: Int
    let results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}


struct SearchResult: Codable, Hashable {
     
    let id: String
    let urls: Urls
    let likes: Int
    
}


struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb: String
}
