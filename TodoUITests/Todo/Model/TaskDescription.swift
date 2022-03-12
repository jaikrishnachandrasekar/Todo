//
//  TaskDescription.swift
//  Todo
//
//  Created by admin on 3/9/22.
//

import Foundation

struct TaskDescription: Codable {
    var title: String
    var author: String
    var tag: String
    var isCompleted: Bool
    var priority: Priority?
    var id: Int

    enum CodingKeys: String, CodingKey {
        case title, author, tag
        case isCompleted = "is_completed"
        case priority, id
    }
}
