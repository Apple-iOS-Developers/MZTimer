//
//  TimerView.swift
//  MZTimer WatchKit Extension
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import SwiftUI

struct TimerView: View {

    @Binding var pushTimer: Bool

    @ObservedObject var timerViewModel: WatchTimerViewModel
    @State private var isStopPressed: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing:5){
                Text("\(timerViewModel.getCurrentCategory().titleWithEmoji())")
                    .bold()
                    .foregroundColor(.textGreen)

                Text("\(timerViewModel.hours):\(timerViewModel.minutes):\(timerViewModel.seconds)")
                    .font(.largeTitle)
            }
            Spacer()
            HStack{
                Text("Stop")
                    .bold()
                    .frame(width: 80, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
                    .background(Color.rowBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .onTapGesture {
                        isStopPressed = true
                    }
                    .actionSheet(isPresented: $isStopPressed, content: {
                        ActionSheet(
                            title: Text("End event"),
                            message: Text("Confirm end current event"),
                            buttons: [
                                ActionSheet.Button.default(Text("Confirm"), action: {
                                    DispatchQueue.main.async {
                                        timerViewModel.stop {
                                            pushTimer.toggle()
                                        }
                                    }
                                }),
                                .cancel({
                                    isStopPressed = false
                                })
                            ]
                        )
                    })
                
                
                Text(timerViewModel.isPaused ?  "Resume" : "Paused")
                    .bold()
                    .frame(width: 80, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.rowBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .onTapGesture {
                        if timerViewModel.isPaused {
                            timerViewModel.resume()
                        } else {
                            timerViewModel.pause()
                        }
                    }
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(pushTimer: .constant(true), timerViewModel: WatchTimerViewModel(currentCategory: Category(emoji: "asd", title: "aasd")))
    }
}
