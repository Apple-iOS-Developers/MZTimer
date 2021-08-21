//
//  Extensions.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI



private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Int {
    func calculateRamenCount() -> Int {
        return self/60*3
    }

    func calculateBabyBornCount() -> Int {
        return self/4
    }

    func calculateDeathCount() -> Int {
        return self/2
    }

    func calculateFlightOnBoard() -> Int {
        return self*160
    }
    func calculateTreeCutted() -> Int {
        return self*40
    }
}
extension String {
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
