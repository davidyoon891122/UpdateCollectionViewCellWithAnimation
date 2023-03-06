//
//  CompanyModel.swift
//  UpdateCellWithAnimation
//
//  Created by jiwon Yoon on 2023/03/06.
//

import Foundation

struct CompanyModel: Decodable {
    let name: String
    var score: Int
    let modifiedDate: String
    var likeCount: Int
    var dislikeCount: Int
}
