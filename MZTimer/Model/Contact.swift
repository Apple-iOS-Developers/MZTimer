//
//  PhoneBookModel.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import Foundation

struct Contact: Hashable, Codable {
    let uuid : UUID
    let name : String
    let phoneNumber: String
    let memo: String

    
    init(name: String, phoneNumber: String, memo: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.memo = memo
        self.uuid = UUID()
    }
}
