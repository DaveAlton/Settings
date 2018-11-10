//
//  ViewController.swift
//  Settings
//
//  Created by Dave Alton on 11/10/18.
//  Copyright © 2018 Dave. All rights reserved.
//

import UIKit

protocol SettingsCellProtocol {
    var isUserInteractionEnabled: Bool { get set }
    var accessoryType: UITableViewCell.AccessoryType { get set }
    func setValue(_ value: Any?)
    func setLabel(_ text: String)
    func setInteraction(_ interaction: (() -> Void)?)
}

enum Setting {
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

    var settings = [Setting]()
    
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

    func goToWebsite() {
        UIApplication.shared.open(URL(string: "https://www.expedia.com")!, options: [:], completionHandler: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: setting.reuseIdentifier, for: indexPath) as! SettingsCellProtocol
        cell.isUserInteractionEnabled = setting.userInteractionEnabled
        cell.accessoryType = setting.accessoryType
        cell.setLabel(setting.label)
        cell.setInteraction({
            switch setting {
            case .awesomeMode: self.awesomeSwitchTapped()
            case .faceID:      self.faceIDSwitchTapped()
            case .website:     self.goToWebsite()
            case .appVersion:  return
            }
        })
        
        cell.setValue({
            switch setting {
            case .awesomeMode: return self.awesomeMode
            case .faceID:      return self.faceIDOn
            case .website:     return nil
            case .appVersion:  return nil
            }
        }())
        return cell as! UITableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
