//
//  priority.swift
//  Todo
//
//  Created by admin on 3/9/22.
//

import UIKit

enum Priority: String, Codable {
    case high = "HIGH"
    case low = "LOW"
    case medium = "MEDIUM"
    
     func getColor() -> UIColor
    {
        switch self {
        case .high:
            return UIColor.red
        case .medium:
            return UIColor.yellow
        default:
            return UIColor.green
        }
    }
}
