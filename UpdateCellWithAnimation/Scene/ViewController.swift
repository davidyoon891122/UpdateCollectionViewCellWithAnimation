//
//  ViewController.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import UIKit
import SnapKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMockData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.identifier,
            for: indexPath
        ) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell()
        
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
    
    func loadMockData() {
        let mockDataFileName = "CompanyMockData"
        guard let path = Bundle.main.path(
            forResource: mockDataFileName,
            ofType: "json"
        ) else {
            print("Can't find the mock data : \(mockDataFileName).json")
            return
        }
        
        guard let jsonString = try? String(contentsOfFile: path) else {
            print("Can't load file to jsonString")
            return
        }
        
        print(jsonString)
        
        do {
            let model = try JSONDecoder().decode([CompanyModel].self, from: jsonString.data(using: .utf8)!)
            print(model)
        } catch let error {
            print(error)
        }
    }
}

