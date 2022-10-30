//
//  MainViewController.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa


final class MainViewController: BaseViewController {

    // MARK: - Propertys
    private let memoButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.setTitle("Memo", for: .normal)
    }
    
    private let unsplashButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.setTitle("Unsplash", for: .normal)
    }

    
       
    
    // MARK: - Methods
    override func configure() {
        configureUI()
        bind()
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [memoButton, unsplashButton].forEach { view.addSubview($0) }
        
        memoButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        }
        
        unsplashButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
            make.top.equalTo(memoButton.snp.bottom).offset(50)
        }
    }
    
    
    private func bind() {
        memoButton.rx.tap.withUnretained(self)
            .bind { (vc, _) in
                let memoVC = MemoListViewController()
                vc.transition(memoVC, transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        unsplashButton.rx.tap.withUnretained(self)
            .bind { (vc, _) in
                let unsplashVC = UnsplashViewController()
                vc.transition(unsplashVC, transitionStyle: .push)
            }
            .disposed(by: disposeBag)
    }
}
