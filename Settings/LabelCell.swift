//
//  LabelCell.swift
//  Settings
//
//  Created by Dave Alton on 11/10/18.
//  Copyright © 2018 Dave. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    var interaction: (() -> Void)?
    @IBOutlet var label: UILabel!

    required init(coder: NSCoder) {
        super.init(coder: coder)!

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LabelCell.didTap))
        self.contentView.addGestureRecognizer(tapGesture)
    }

    @objc func didTap() {
        interaction?()
    }
}

extension LabelCell: SettingsCellProtocol {
    func setLabel(_ text: String) {
        self.label.text = text
    }

    func setInteraction(_ interaction: (() -> Void)?) {
        self.interaction = interaction
    }

    func setValue(_ value: Any?) {
        return
    }
}
