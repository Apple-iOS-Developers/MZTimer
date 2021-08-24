//
//  iMessageHelper.swift
//  MZTimer
//
//  Created by TaeHyeong Kim on 2021/08/25.
//

import Foundation
import UIKit

class iMessageHelper {
    class func makeMessage(message: String, event: Event) {
        let messageBody = "김태형님이 \n[\(message)]를 완료했습니다 \n 수행시간:\(event.time)시"
        let urlSafeBody = messageBody.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let phoneNumber: [String] = UserDefaultStorage.shared.loadContact().map{ $0.phoneNumber }
        let phoneString = phoneNumber.joined(separator: ",")

        if let urlSafeBody = urlSafeBody, let url = NSURL(string: "sms:/open?addresses=\(phoneString)&&body=\(urlSafeBody)") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
