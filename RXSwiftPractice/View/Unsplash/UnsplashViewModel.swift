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
    var searchResult = BehaviorSubject<[SectionOfCustomData]>(value: [])
    
    
    
    
    // MARK: - Methods
    func searchPhoto(_ bag: DisposeBag, query: String) {
        APIManager.searchPhoto(bag, query: query) { [weak self] searchPhoto in
            self?.searchResult.onNext([SectionOfCustomData(header: query, items: searchPhoto.results)])
        }
    }
    
    
    func bind(_ bag: DisposeBag, handler: @escaping ([SectionOfCustomData]) -> Void) {
        searchResult.bind { value in
            handler(value)
        }
        .disposed(by: bag)
    }
    
}




// MARK: - Input / Output
extension UnsplashViewModel: CommonViewModel {
    
    struct Input {
        let searchTap: ControlEvent<Void>
    }
    
    struct Output {
        let searchTap: ControlEvent<Void>
        let searchResult: BehaviorSubject<[SectionOfCustomData]>
    }
    
    func transfrom(input: Input) -> Output {
        let output = Output(searchTap: input.searchTap, searchResult: searchResult)
        return output
    }
    
    
}
