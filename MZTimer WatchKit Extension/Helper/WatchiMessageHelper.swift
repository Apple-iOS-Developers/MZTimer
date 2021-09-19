//
//  WatchiMessageHelper.swift
//  MZTimer WatchKit Extension
//
//  Created by TaeHyeongKim on 2021/09/19.
//

import Foundation
import WatchKit

class WatchiMessageHelper {
    class func makeMessage(message: String, event: Event) {
        let messageBody = "김태형님이 \n[\(message)]를 완료했습니다 \n 수행시간:\(event.time)시"
        let urlSafeBody = messageBody.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let phoneNumber: [String] = WatchUserDefaultStorage.shared.loadContact().map{ $0.phoneNumber }
        let phoneString = phoneNumber.joined(separator: ",")

        if let urlSafeBody = urlSafeBody, let url = NSURL(string: "sms:/open?addresses=\(phoneString)&&body=\(urlSafeBody)") {
            WKExtension.shared().openSystemURL(url as URL)
        }
    }
}
