//
//  TimerResultView.swift
//  MZTimer WatchKit Extension
//
//  Created by TaeHyeongKim on 2021/09/19.
//

import SwiftUI

struct TimerResultView: View {

    @State var event: Event
    @Binding var showTimerResultView: Bool
    
    @EnvironmentObject var viewModel: WatchViewModel

    var body: some View {
        ScrollView{
            VStack(alignment:.leading) {
                Text(event.emoji)
                    .font(.largeTitle)
                
                Text(event.title)
                    .font(.body)
                    .foregroundColor(Color.textGreen)
                    .bold()
                
                Spacer()

                Text("total time")
                    .font(.body)
                    .foregroundColor(Color.textGreen)
                    .underline()
                
                Text("\(event.time.convertTimeToString())")
                    .font(.footnote)

                Text("start date")
                    .font(.body)
                    .foregroundColor(Color.textGreen)
                    .underline()
         
                
                Text("\(event.startDate.dateWithTimeSecondsString())")
                    .font(.footnote)

                Text("end date")
                    .font(.body)
                    .foregroundColor(Color.textGreen)
                    .underline()
                
                Text("\(event.endDate.dateWithTimeSecondsString())")
                    .font(.footnote)
                

            
            }
            VStack(alignment:.leading, spacing: 3) {
                Button(action: {
                    showTimerResultView = false
                }, label: {
                    Text("Done")
                        .font(.caption)
                        .foregroundColor(Color.textGreen)
                })
                
                Button(action: {
                    viewModel
                        .sendEventDataToPhone(event: Event(emoji: "", title: "", time: 0, endDate: Date())) { result in
                        
                    }
                }, label: {
                    Text("Add to iCalendar")
                        .font(.caption)
                        .foregroundColor(Color.textGreen)
                })
            }
        }
        .frame(
            width: WKInterfaceDevice.currentResolution == .watch38mm ? 136: 156
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("Result"))

    }
}

struct TimerResultView_Previews: PreviewProvider {
    static var previews: some View {
        TimerResultView(event: Event(emoji: "👻", title: "술래잡기 고무줄놀이", time: 1000, endDate: Date()), showTimerResultView: .constant(true))
    }
}
