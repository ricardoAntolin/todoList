//
//  CreateTodoNavigator.swift
//  todoist
//
//  Created by Ricardo Antolin on 4/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol CreateTodoNavigator {
    
    func toTodoList()
}

final class DefaultCreateTodoNavigator: CreateTodoNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toTodoList() {
        navigationController.dismiss(animated: true)
    }
}
