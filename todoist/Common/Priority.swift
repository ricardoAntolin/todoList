//
//  Priority.swift
//  todoist
//
//  Created by Ricardo Antolin on 15/10/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation

enum Priority: String {
    case LOW = "LOW", MEDIUM = "MEDIUM", HIGH = "HIGH"
    
    static var count: Int { return Priority.HIGH.hashValue + 1}
    
    static func fromHashValue(hashValue: Int) -> Priority {
        switch hashValue {
        case 1:
            return .MEDIUM
        case 2:
            return .HIGH
        default:
            return .LOW
        }
    }
}
