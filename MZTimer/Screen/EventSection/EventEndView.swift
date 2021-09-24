//
//  EventEndVIew.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI
import Combine

struct EventEndView: View {
    @ObservedObject var viewModel: EventEndViewModel
    
    var body: some View {
        VStack(spacing:20) {
            
            Spacer()

            HStack(alignment:.center) {
                Text(viewModel.event.emoji).font(.system(size: 60))
                Text(viewModel.event.title).font(.largeTitle)
            }

            VStack(alignment:.center, spacing:10){
                Text("Total: \(viewModel.event.time.convertTimeToString())").font(.system(size: 20))
                    .bold()
                Text("start: \(viewModel.event.startDate.dateWithTimeString())")
                Text("end: \(viewModel.event.endDate.dateWithTimeString())")
            }

//            VStack(spacing:10){
//                Text("🍜라면을 총 \(event.time.toRamenTime())개 끓였습니다. ")
//                Text("최저시급 기준 \(event.time.toWageTime())원을 벌었습니다.")
//            }
            Spacer()
            
            HStack(alignment:.center) {
                
                Spacer()
                
                Button("Export to iCalender") {
                    viewModel.action.exportToCalender.send(())
                }
                .foregroundColor(.yellow)
                .frame(width: 180, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.blue.opacity(0.5))
                .cornerRadius(10)

                Spacer()
                
                Button("Share to Friends") {
                    viewModel.action.shareToFriend.send(())
                }
                .frame(width: 180, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.blue)
                .background(Color.yellow)
                .cornerRadius(10)
                
                Spacer()
            }
            
            Spacer().frame(height:20)

        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .preferredColorScheme(.dark)
    }
}

struct EventEndView_Previews: PreviewProvider {
    static var previews: some View {
        EventEndView(viewModel: EventEndViewModel(event: Event(emoji: "🥯", title: "빵먹기", time: 100, startDate: Date())))
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

class EventEndViewModel: NSObject, ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    let event: Event
    
    struct Action {
        var shareToFriend = PassthroughSubject<Void,Never>()
        var exportToCalender = PassthroughSubject<Void,Never>()
    }
    
    let action = Action()
    
    init(event: Event) {
        self.event = event
        super.init()
        
        action.shareToFriend
            .sink(receiveValue: {
                iMessageHelper.makeMessage(event: event)
            }).store(in: &cancellables)
        
        action.exportToCalender
            .filter{ iCalenderHelper.shared.checkEventStorePermission() }
            .sink(receiveValue: {
                let iCalEvent = iCalenderEvent(title: "\(event.emoji)\(event.title)", note: "From MZTimer", time: event.time, startDate: event.startDate)
                iCalenderHelper.shared.addEvent(event: iCalEvent)
            }).store(in: &cancellables)
    }

}
