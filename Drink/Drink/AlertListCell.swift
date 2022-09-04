//
//  AlertListCell.swift
//  Drink
//
//  Created by 이준혁 on 2022/09/05.
//

import UIKit
import UserNotifications

class AlertListCell: UITableViewCell {
    
    var userNotificationCenter = UNUserNotificationCenter.current()

    @IBOutlet var meridiemLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var alertSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func alertSwitchValueChanged(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return }
        
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        
        if sender.isOn {
            userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
    
}
