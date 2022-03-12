//
//  model.swift
//  Todo
//
//  Created by admin on 3/9/22.
//

import Foundation

struct TodoData: Codable {
    let data: [DataDescription]
    let totalRecords: Int

    enum CodingKeys: String, CodingKey {
        case data
        case totalRecords = "total_records"
    }
}
