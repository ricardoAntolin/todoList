//
//  TodoTableViewCell.swift
//  todoist
//
//  Created by Ricardo Antolin on 3/6/17.
//  Copyright © 2017 Ricardo Antolin. All rights reserved.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var doneSwitch: UISwitch!
    @IBOutlet weak var priorityImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
}
