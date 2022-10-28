//
//  MemoListViewController.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/10/28.
//

import UIKit


final class MemoListViewController: BaseViewController {

    // MARK: - Propertys
    private let viewModel = MemoViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Memo>!
    
    
    
    
    // MARK: - LifeCycle
    private let memoListView = MemoListView()
    override func loadView() {
        view = memoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TestData
//        (1...10).forEach {
//            let memo = Memo(title: "\($0) title", content: "\($0) content")
//            try? viewModel.create(memo)
//        }
    }
    
    
    
    
    // MARK: - Methods
    override func configure() {
        setNavigationBar()
        setToolBar()
        
        memoListView.collectionView.delegate = self
        configureDataSource()
        
        bind()
    }
    
    
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = "메모"
    }
    
    
    private func setToolBar() {
        navigationController?.isToolbarHidden = false
        
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let writeMemoBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(writeButtonTapped))
        writeMemoBarButton.tintColor = .systemOrange
        
        self.toolbarItems = [flexibleSpaceItem, writeMemoBarButton]
    }
    
    
    private func reloadCollectionView() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Memo>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.fetch())
        
        dataSource.apply(snapshot)
    }
    
    
    private func bind() {
        viewModel.bind(disposeBag) { [weak self] in
            self?.reloadCollectionView()
        }
    }
    
    
    
    
    // MARK: - Objc Methods
    @objc private func writeButtonTapped() {
        try? viewModel.create(Memo(title: "추가 : \(Int.random(in: 1...100))", content: "content : \(Int.random(in: 1...100))"))
    }
}




// MARK: - CollectionView Datasource
extension MemoListViewController {
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Memo> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.content
            content.secondaryTextProperties.numberOfLines = 1
            content.prefersSideBySideTextAndSecondaryText = true
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Memo>(collectionView: memoListView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        //reloadCollectionView()
    }
}




// MARK: - CollectionView Delegate
extension MemoListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item) : Selected")
    }
    
}