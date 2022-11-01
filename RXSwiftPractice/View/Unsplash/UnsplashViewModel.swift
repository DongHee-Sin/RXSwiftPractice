//
//  UnsplashViewModel.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import Foundation

import RxSwift
import RxCocoa


enum SearchError: Error {
    case noPhoto
    case serverError
}


final class UnsplashViewModel {
    
    // MARK: - Propertys
    var searchPhotoResult = BehaviorSubject<[SectionOfCustomData]>(value: [])
    
    
    
    
    // MARK: - Methods
    func searchPhoto(_ bag: DisposeBag, query: String) {
        APIManager.searchPhoto(bag, query: query) { [weak self] searchPhoto in
            self?.searchPhotoResult.onNext([SectionOfCustomData(header: query, items: searchPhoto.results)])
        }
    }
    
    
    func bind(_ bag: DisposeBag, handler: @escaping ([SectionOfCustomData]) -> Void) {
        searchPhotoResult.bind { value in
            handler(value)
        }
        .disposed(by: bag)
    }
    
}
