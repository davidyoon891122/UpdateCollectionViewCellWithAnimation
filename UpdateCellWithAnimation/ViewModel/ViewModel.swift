//
//  ViewModel.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import Foundation
import RxSwift

protocol ViewModelInput {
    func requestCompanyScore()
}

protocol ViewModelOutput {
    var companyModelPublishSubject: PublishSubject<[CompanyModel]> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput, ViewModelType {
    var inputs: ViewModelInput { self }
    var outputs: ViewModelOutput { self }
    
    var companyModelPublishSubject: PublishSubject<[CompanyModel]> = .init()
    
    private var disposeBag = DisposeBag()
    
    
    func requestCompanyScore() {
        let companyModels = loadMockData()
        companyModelPublishSubject.onNext(companyModels)
    }
    
    
    private func loadMockData() -> [CompanyModel] {
        let mockDataFileName = "CompanyMockData"
        guard let path = Bundle.main.path(
            forResource: mockDataFileName,
            ofType: "json"
        ) else {
            print("Can't find the mock data : \(mockDataFileName).json")
            return []
        }
        
        guard let jsonString = try? String(contentsOfFile: path) else {
            print("Can't load file to jsonString")
            return []
        }
        
        print(jsonString)
        
        do {
            let model = try JSONDecoder().decode([CompanyModel].self, from: jsonString.data(using: .utf8)!)
            print(model)
            return model
        } catch let error {
            print(error)
            return []
        }
    }
}