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
    @EnvironmentObject var viewModel: WatchViewModel

    @State private var isStopPressed: Bool = false
    @State private var showTimerResultView: Bool = false
    @State private var savedEvent: Event?
    
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

                NavigationLink(
                    destination: TimerResultView(event: savedEvent ?? Event(emoji: "", title: "", time: 0, endDate: Date()), showTimerResultView: $showTimerResultView),
                    isActive: $showTimerResultView,
                    label: {
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
                                                timerViewModel.stop { event in
                                                    savedEvent = event
                                                    showTimerResultView = true
                                                }
                                            }
                                        }) ,
                                        .cancel({
                                            isStopPressed = false
                                        })
                                    ]
                                )
                            })
                    })
                    .buttonStyle(PlainButtonStyle())
                
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
        }
        .onAppear(perform: {
            //pop to rootView 할려면 isDetailLink가 있어야 하는데 watchOS에서는 적용이 안되서 savedEvent도 있을때 한번더 pop
            if showTimerResultView == false && savedEvent != nil {
                pushTimer = false
            }
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("Timer"))
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(pushTimer: .constant(true), timerViewModel: WatchTimerViewModel(currentCategory: Category(emoji: "asd", title: "aasd")))
    }
}
