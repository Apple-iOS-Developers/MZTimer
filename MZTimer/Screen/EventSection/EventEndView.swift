//
//  EventEndVIew.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI

struct EventEndView: View {
    var event: Event
    var body: some View {
        VStack(spacing:20) {

            HStack(alignment:.center) {
                Text(event.emoji).font(.system(size: 60))
                Text(event.title).font(.largeTitle)
            }

            VStack(alignment:.center, spacing:10){
                Text("Total: \(event.time.convertTimeToString())").font(.system(size: 20))
                    .bold()
                Text("start: \(event.startDate.dateWithTimeString())")
                Text("end: \(event.endDate.dateWithTimeString())")
            }

//            VStack(spacing:10){
//                Text("🍜라면을 총 \(event.time.toRamenTime())개 끓였습니다. ")
//                Text("최저시급 기준 \(event.time.toWageTime())원을 벌었습니다.")
//            }
            Spacer().frame(height: 100)

        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .preferredColorScheme(.dark)
    }
}

struct EventEndView_Previews: PreviewProvider {
    static var previews: some View {
        EventEndView(event: Event(emoji: "🥯", title: "빵먹기", time: 100, startDate: Date()))
    }
}
extension Int {
    func toRamenTime() -> Int {
        return self/3
    }
    func toWageTime() -> Int {
        return 8750/60/60*self
    }
}
