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
    
    // MARK: - Propertys
    private let localRealm = try! Realm()
    
    private lazy var memoList = BehaviorRelay(value: localRealm.objects(Memo.self).sorted(byKeyPath: "memoDate"))
    
    
    
    
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
    
    
    func fetch() -> [Memo] {
        var memoArray: [Memo] = []
        memoArray.append(contentsOf: memoList.value)
        return memoArray
    }
    
    
    func bind(_ bag: DisposeBag, handler: @escaping () -> Void) {
        memoList.asDriver(onErrorJustReturn: memoList.value)
            .drive { _ in
                handler()
            }
            .disposed(by: bag)
    }
}
