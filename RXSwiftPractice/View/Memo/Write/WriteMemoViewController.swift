//
//  WriteMemoViewController.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/29.
//

import UIKit

import RxSwift
import RxCocoa


enum WriteViewControllerStatus {
    case write
    case read
}


final class WriteMemoViewController: BaseViewController {

    // MARK: - Propertys
    var viewModel: MemoViewModel?
    
    var status = BehaviorRelay<WriteViewControllerStatus>(value: .write)
    
    
    
    
    // MARK: - Life Cycle
    private let writeView = WriteMemoView()
    override func loadView() {
        view = writeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    // MARK: - Methods
    override func configure() {
        setNavigationBar()
        setToolBar()
        
        bind()
    }
    
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    
    private func setToolBar() {
        navigationController?.isToolbarHidden = false
        
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let writeMemoBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(writeButtonTapped))
        writeMemoBarButton.tintColor = .systemOrange
        
        self.toolbarItems = [flexibleSpaceItem, writeMemoBarButton]
    }
    
    
    private func bind() {
        status.withUnretained(self).bind { (vc, status) in
            switch status {
            case .write: vc.writeView.textView.becomeFirstResponder()
            case .read: vc.writeView.textView.resignFirstResponder()
            }
        }
        .disposed(by: disposeBag)
    }
    
    
    
    
    // MARK: - Objc Methods
    @objc private func writeButtonTapped() {
        try? viewModel?.create(Memo(title: "추가 : \(Int.random(in: 1...100))", content: "content : \(Int.random(in: 1...100))"))
    }
}
