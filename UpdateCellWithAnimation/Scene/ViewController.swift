//
//  ViewController.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    private lazy var mainCollectionView: UICollectionView = {
        let layout = DynamicHeightFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        
        collectionView.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
    private var disposeBag = DisposeBag()
    
    private var viewModel: ViewModelType = ViewModel()
    
    private var companies: [CompanyModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputs.requestCompanyScore()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return companies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.identifier,
            for: indexPath
        ) as? CollectionViewCell else { return UICollectionViewCell() }
        
        let company = companies[indexPath.item]
        cell.setupCell(company: company)
        
        return cell
    }
}

private extension ViewController {
    func setupViews() {
        [
            mainCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.outputs.companyModelPublishSubject
            .subscribe(onNext: { [weak self] companyModel in
                guard let self = self else { return }
                self.companies = companyModel
                self.mainCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

