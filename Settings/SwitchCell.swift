//
//  SwitchCell.swift
//  Settings
//
//  Created by Dave Alton on 11/10/18.
//  Copyright © 2018 Dave. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {
    var interaction: (() -> Void)?
    @IBOutlet var label: UILabel!
    @IBOutlet var `switch`: UISwitch!

    @IBAction func switchToggled(_ sender: UISwitch) {
        interaction?()
    }
}

extension SwitchCell: SettingsCellProtocol {
    func setLabel(_ text: String) {
        self.label.text = text
    }

    func setInteraction(_ interaction: (() -> Void)?) {
        self.interaction = interaction
    }

    func setValue(_ value: Any?) {
        self.`switch`.setOn((value as? Bool == true), animated: false)
    }

    
}
