//
//  model.swift
//  Todo
//
//  Created by admin on 3/9/22.
//

import Foundation

struct TodoDataList: Codable {
    let data: [TaskDescription]
    let totalRecords: Int

    enum CodingKeys: String, CodingKey {
        case data
        case totalRecords = "total_records"
    }
}
