//
//  MemoListViewModel.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/28.
//

import Foundation

import RealmSwift
import RxSwift
import RxCocoa


enum RealmError: Error {
    case writeError
    case updateError
    case deleteError
}


final class MemoViewModel {
    
    // MARK: - Init
    init() {
        memoResults = localRealm.objects(Memo.self).sorted(byKeyPath: "memoDate")
        
        notificationToken = memoResults.observe { [weak self] _ in
            guard let self else { return }
            self.memoArray.accept(self.convertResultsToArray())
        }
    }
    
    
    
    
    // MARK: - Propertys
    private let localRealm = try! Realm()
    
    private var notificationToken: NotificationToken?
    
    private var memoResults: Results<Memo>
    
    private var memoArray = PublishRelay<[Memo]>()
    
    
    
    
    // MARK: - Methods
    func create(_ memo: Memo) throws {
        do {
            try localRealm.write {
                localRealm.add(memo)
            }
        }
        catch {
            throw RealmError.writeError
        }
    }
    
    
    func delete(_ memo: Memo) throws {
        do {
            try localRealm.write {
                localRealm.delete(memo)
            }
        }
        catch {
            throw RealmError.deleteError
        }
    }
    
    
    func bind(_ bag: DisposeBag, handler: @escaping ([Memo]) -> Void) {
        memoArray.bind { value in
            handler(value)
        }
        .disposed(by: bag)
    }
    
    
    private func convertResultsToArray() -> [Memo] {
        var memoArray: [Memo] = []
        memoArray.append(contentsOf: memoResults)
        return memoArray
    }
}
