//
//  MemoListViewController.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/28.
//

import UIKit


final class MemoListViewController: BaseViewController {

    // MARK: - LifeCycle
    private let memoListView = MemoListView()
    override func loadView() {
        view = memoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    // MARK: - Methods
    override func configure() {
        setNavigationBar()
        setToolBar()
    }
    
    
    private func setNavigationBar() {
        
    }
    
    
    private func setToolBar() {
        
    }
}
