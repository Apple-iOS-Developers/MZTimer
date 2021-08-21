//
//  TimerView.swift
//  MZTimer WatchKit Extension
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import SwiftUI

struct TimerView: View {
    @State var milliSecond = 0
    @State var second = 0
    @State var minute = 0
    @State var hour = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isTimerStopped : Bool = false
    @Binding var pushTimer: Bool
    
    var body: some View {
        VStack{
            VStack(spacing:5){
                Text("디자인 패턴 공부하기")
                    .bold()
                    .foregroundColor(.textGreen)
                
                let timerText = String(format:"%02i:%02i:%02i", hour, minute, second)
                
                Text(timerText)
                    .font(.largeTitle)
                    .onReceive(timer) { _ in
                        milliSecond += 1000
                        if milliSecond == 1000 {
                            second += 1
                            milliSecond = 0
                        }
                        if second == 60 {
                            minute += 1
                            second = 0
                        }
                        if minute == 60 {
                            hour += 1
                            minute = 0
                        }
                    }
            }
            Spacer()
            HStack{
                Text("종료")
                    .bold()
                    .frame(width: 80, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
                    .background(Color.rowBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .onTapGesture {
                        
                        let messageBody = "Hello World! 공부 \("\(hour):\(minute):\(second)")했슴둥!"
                        let urlSafeBody = messageBody.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                        let phoneNumber = ["010-5577-0860","010-2767-6818"]
                        let phoneString = phoneNumber.joined(separator: ",")
                        
                        if let urlSafeBody = urlSafeBody, let url = NSURL(string: "sms:/open?addresses=010-5577-0860,010-2767-6818&&body=\(urlSafeBody)") {
                            WKExtension.shared().openSystemURL(url as URL)
                        }
                        pushTimer.toggle()
                    }
                
                
                Text(isTimerStopped ?  "계속하기" : "일시정지")
                    .bold()
                    .frame(width: 80, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.rowBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .onTapGesture {
                        if isTimerStopped {
                            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            
                        } else {
                            timer.upstream.connect().cancel()
                        }
                        isTimerStopped.toggle()
                    }
            }
        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(pushTimer: .constant(true))
    }
}
