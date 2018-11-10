//
//  ViewController.swift
//  Settings
//
//  Created by Dave Alton on 11/10/18.
//  Copyright © 2018 Dave. All rights reserved.
//

import UIKit

enum Settings {
    case awesomeMode, faceID, website, appVersion

    var reuseIdentifier: String {
        switch self {
        case .awesomeMode: return "SwitchCell"
        case .faceID:      return "SwitchCell"
        case .website:     return "LabelCell"
        case .appVersion:  return "LabelCell"
        }
    }

    var userInteractionEnabled: Bool {
        switch self {
        case .awesomeMode: return true
        case .faceID:      return true
        case .website:     return true
        case .appVersion:  return false
        }
    }

    var label: String {
        switch self {
        case .awesomeMode: return "Awesome Mode"
        case .faceID:      return "FaceID"
        case .website:     return "Expedia.com"
        case .appVersion:  return "App Version: 2.0"
        }
    }

    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .awesomeMode: return .none
        case .faceID:      return .none
        case .website:     return .disclosureIndicator
        case .appVersion:  return .none
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var awesomeMode = false
    var faceIDAvailable = true
    var faceIDOn = false
    var settings = [Settings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settings = [.awesomeMode]
        if faceIDAvailable {
            settings += [.faceID]
        }
        settings += [.website, .appVersion]

        tableView.reloadData()
    }

    func awesomeSwitchTapped() {
        awesomeMode = !awesomeMode
        guard awesomeMode else { return }
        let alert = UIAlertController(title: "Awesome", message: "You just activated 'Awesome Mode'", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func faceIDSwitchTapped() {
        faceIDOn = !faceIDOn
        guard faceIDOn else { return }
        let alert = UIAlertController(title: "FaceID", message: "You just activated 'FaceID'", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: setting.reuseIdentifier, for: indexPath)
        cell.isUserInteractionEnabled = setting.userInteractionEnabled
        cell.accessoryType = setting.accessoryType
        (cell as? SwitchCell)?.label.text = setting.label
        (cell as? LabelCell)?.label.text = setting.label

        if setting == .awesomeMode {
            (cell as? SwitchCell)?.switchHandler = awesomeSwitchTapped
            (cell as? SwitchCell)?.`switch`.setOn(awesomeMode, animated: false)
        } else if (faceIDAvailable && indexPath.row == 1) {
            (cell as? SwitchCell)?.switchHandler = faceIDSwitchTapped
            (cell as? SwitchCell)?.`switch`.setOn(faceIDOn, animated: false)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let setting = settings[indexPath.row]
        if setting == .website {
            UIApplication.shared.open(URL(string: "https://www.expedia.com")!, options: [:], completionHandler: nil)
        }
    }
}
