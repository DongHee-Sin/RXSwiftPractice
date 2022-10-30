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
    private var searchPhotoResult = BehaviorSubject<[SearchResult]>(value: [])
    
    
    
    
    // MARK: - Methods
    func searchPhoto(query: String) {
        APIManager.searchPhoto(query: query) { [weak self] searchPhoto, code, error in
            guard let code, code == 200 else {
                self?.searchPhotoResult.onError(SearchError.serverError)
                return
            }
            
            guard let searchPhoto else {
                self?.searchPhotoResult.onError(SearchError.noPhoto)
                return
            }
            
            self?.searchPhotoResult.onNext(searchPhoto.results)
        }
    }
    
    
    func bind(_ bag: DisposeBag, handler: @escaping ([SearchResult]) -> Void) {
        searchPhotoResult.bind { value in
            handler(value)
        }
        .disposed(by: bag)
    }
    
}
