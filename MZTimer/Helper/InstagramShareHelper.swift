//
//  InstagramShareHelper.swift
//  MZTimer
//
//  Created by TaeHyeong Kim on 2021/09/23.
//

import Foundation
import UIKit
import SwiftUI

enum InstagramShareResult {
    case success
    case fail
}

class InstagramShareHelper {
    static func shareToInstagram(event: Event, completion: @escaping (InstagramShareResult) -> Void) {
        if let urlScheme = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                
                //let logoImage = #imageLiteral(resourceName: "logo")
                //"com.instagram.sharedSticker.stickerImage": logoImage.pngData()!,
                let shareImage = InstaStoryShareView(event: event).snapshot()
                
                let pasteboardItems: [String:Any] = ["com.instagram.sharedSticker.backgroundImage": shareImage.pngData()!]

                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)]

                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(urlScheme as URL, options: [:], completionHandler: nil)
                completion(.success)
            } else {
                completion(.fail)
            }
        }
    }
    
    static func text2Image(event: Event) -> UIImage {
        let title = "\(event.emoji)\(event.title)"
        let description = "\(event.startDate.dateWithTimeString()) ~ \(event.endDate.dateWithTimeString())"
        let time = "\(event.time)"
        
        let text = title + description + time
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.green,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)
        ]
        
        let textSize = text.size(withAttributes: attributes)

        let renderer = UIGraphicsImageRenderer(size: textSize)
        
        return renderer.image(actions: { context in
            text.draw(at: CGPoint.zero, withAttributes: attributes)
        })
    }
}
// 추후 인스타 공유시 view -> image util code
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
