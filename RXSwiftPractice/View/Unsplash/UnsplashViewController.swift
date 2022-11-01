//
//  UnsplashViewController.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import UIKit

import RxDataSources
import RxSwift
import RxCocoa


final class UnsplashViewController: BaseViewController {

    // MARK: - Propertys
    private let viewModel = UnsplashViewModel()
    
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfCustomData>!
    
    
    
    
    // MARK: - Life Cycle
    private let unsplashView = UnsplashView()
    override func loadView() {
        view = unsplashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    // MARK: - Methods
    override func configure() {
        view.backgroundColor = .white
        
        configureDataSource()
        unsplashView.collectionView.delegate = self
        
        bind()
    }
    

    private func bind() {
        let input = UnsplashViewModel.Input(searchTap: unsplashView.searchBar.rx.searchButtonClicked)
        let output = viewModel.transfrom(input: input)
        
        output.searchTap.withUnretained(self)
            .bind { (vc, _) in
                if let query = vc.unsplashView.searchBar.text, query != "" {
                    vc.viewModel.searchPhoto(vc.disposeBag, query: query)
                }
            }
            .disposed(by: disposeBag)
        
        
        output.searchResult
            .bind(to: unsplashView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}




// MARK: - CollectionView DataSource
extension UnsplashViewController {
    
    private func configureDataSource() {
        unsplashView.collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "cell")
        
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            itemIdentifier.urls.thumb.toImage { image in
                content.image = image
                cell.contentConfiguration = content
            }
        }
        
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCustomData> { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
            return cell
        }
    }
    
}




// MARK: - CollectionView Delegate
extension UnsplashViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected : \(indexPath.item)")
    }
    
}
