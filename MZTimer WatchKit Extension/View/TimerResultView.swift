//
//  TimerResultView.swift
//  MZTimer WatchKit Extension
//
//  Created by TaeHyeongKim on 2021/09/19.
//

import SwiftUI

struct TimerResultView: View {

    @State var event: Event

    var body: some View {
        ScrollView{
            VStack(alignment:.leading) {
                Text(event.emoji).font(.largeTitle)
                Text(event.title).font(.body).foregroundColor(Color.textGreen)
                Spacer()

                Text("total time").font(.body).foregroundColor(Color.textGreen).underline()
                Text("\(event.time.convertTimeToString())")

                Text("start date").font(.body).foregroundColor(Color.textGreen).underline()
                Text("\(event.startDate.dateWithTimeString())")

                Text("end date").font(.body).foregroundColor(Color.textGreen).underline()
                Text("\(event.endDate.dateWithTimeString())")

                Button(action: {

                }, label: {
                    Text("Done").font(.caption).foregroundColor(Color.textGreen)
                })

            }
        }
        .frame(
            width: WKInterfaceDevice.currentResolution == .watch38mm ? 136: 156
        )
    }
}

struct TimerResultView_Previews: PreviewProvider {
    static var previews: some View {
        TimerResultView(event: Event(emoji: "👻", title: "술래잡기 고무줄놀이", time: 1000, endDate: Date()))
    }
}
