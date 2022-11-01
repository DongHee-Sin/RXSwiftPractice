//
//  UnsplashViewController.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/30.
//

import UIKit


final class UnsplashViewController: BaseViewController {

    // MARK: - Propertys
    private let viewModel = UnsplashViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    
    
    
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
    
    
    private func reloadCollectionView(_ value: [SearchResult]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(value)
        dataSource.apply(snapshot)
    }

    
    private func bind() {
        unsplashView.searchBar.rx.searchButtonClicked.withUnretained(self)
            .bind { (vc, _) in
                if let query = vc.unsplashView.searchBar.text, query != "" {
                    vc.viewModel.searchPhoto(vc.disposeBag, query: query)
                }
            }
            .disposed(by: disposeBag)
        
        
        viewModel.bind(disposeBag) { [weak self] value in
            self?.reloadCollectionView(value)
        }
    }
}




// MARK: - CollectionView DataSource
extension UnsplashViewController {
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            itemIdentifier.urls.thumb.toImage { image in
                content.image = image
                cell.contentConfiguration = content
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, SearchResult>(collectionView: unsplashView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
}




// MARK: - CollectionView Delegate
extension UnsplashViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected : \(indexPath.item)")
    }
    
}
