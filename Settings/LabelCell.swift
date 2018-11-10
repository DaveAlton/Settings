//
//  LabelCell.swift
//  Settings
//
//  Created by Dave Alton on 11/10/18.
//  Copyright © 2018 Dave. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    var tapHandler: (() -> Void)?
    @IBOutlet var label: UILabel!
}
