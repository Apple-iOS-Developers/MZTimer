//
//  iMessageHelper.swift
//  MZTimer
//
//  Created by TaeHyeong Kim on 2021/08/25.
//

import Foundation
import UIKit

class iMessageHelper {
    class func makeMessage(event: Event) {
        guard let username = UserDefaults.standard.string(forKey: "UserName") else { return }

        let messageBody = "\(username) completed \n[\(event.emoji)\(event.title)] \ntime:\(event.time.convertTimeToString())"
        let urlSafeBody = messageBody.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let phoneNumber: [String] = UserDefaultStorage.shared.loadContact().map{ $0.phoneNumber }
        let phoneString = phoneNumber.joined(separator: ",")

        if let urlSafeBody = urlSafeBody, let url = NSURL(string: "sms:/open?addresses=\(phoneString)&&body=\(urlSafeBody)") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
