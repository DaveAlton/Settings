//
//  ViewController.swift
//  Settings
//
//  Created by Dave Alton on 11/10/18.
//  Copyright © 2018 Dave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var awesomeMode = false
    var faceIDAvailable = true
    var faceIDOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        var cells = 3
        if faceIDAvailable {
            cells += 1
        }
        return cells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            cell.switchHandler = awesomeSwitchTapped
            cell.isUserInteractionEnabled = true
            cell.`switch`.setOn(awesomeMode, animated: false)
            cell.label.text = "Awesome Mode"
            return cell
        } else if (faceIDAvailable && indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            cell.switchHandler = faceIDSwitchTapped
            cell.isUserInteractionEnabled = true
            cell.`switch`.setOn(faceIDOn, animated: false)
            cell.label.text = "Use FaceID"
            return cell
        } else if (!faceIDAvailable && indexPath.row == 1) || (faceIDAvailable && indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelCell
            cell.isUserInteractionEnabled = true
            cell.accessoryType = .disclosureIndicator
            cell.label.text = "Expedia.com"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelCell
            cell.isUserInteractionEnabled = false
            cell.label.text = "App Version: 1.0"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 1 {
            UIApplication.shared.open(URL(string: "https://www.expedia.com")!, options: [:], completionHandler: nil)
        }
    }
}
