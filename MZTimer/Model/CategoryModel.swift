//
//  CategoryModel.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import Foundation

struct Category: Hashable, Codable {
    let uuid : UUID
    let emoji: String
    let title: String
    init(emoji: String, title: String) {
        self.emoji = emoji
        self.title = title
        self.uuid = UUID()
    }
    func titleWithEmoji() -> String {
        return "\(emoji) \(title)"
    }
}


