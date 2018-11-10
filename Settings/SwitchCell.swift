//
//  SwitchCell.swift
//  Settings
//
//  Created by Dave Alton on 11/10/18.
//  Copyright © 2018 Dave. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {
    var switchHandler: (() -> Void)?
    @IBOutlet var label: UILabel!
    @IBOutlet var `switch`: UISwitch!

    @IBAction func switchToggled(_ sender: UISwitch) {
        switchHandler?()
    }
}
