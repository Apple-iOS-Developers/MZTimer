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

            VStack {
                HStack(alignment:.center) {
                    
                    Button {
                        viewModel.action.exportToCalender.send(())
                    } label: {
                        Text("Export to iCalender").bold()
                    }
                    .foregroundColor(.yellow)
                    .frame(width: UIScreen.main.bounds.width/2-20, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.blue.opacity(0.5))
                    .cornerRadius(10)
                    .contentShape(Rectangle())

                    
                    Button {
                        viewModel.action.shareToFriend.send(())
                    } label: {
                        Text("Share to Friends").bold()
                    }
                    .contentShape(Rectangle())
                    .frame(width: UIScreen.main.bounds.width/2-20, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.blue)
                    .background(Color.yellow)
                    .cornerRadius(10)
 
                    
                }
                
                Button {
                    viewModel.action.shareToInstagram.send(())
                } label: {
                    Text("Share to Instagram Story").bold()
                }
                .frame(width: UIScreen.main.bounds.width-35, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(10)
                .contentShape(Rectangle())
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
    
    struct State {
        var showAlert = PassthroughSubject<String, Never>()
    }
    
    struct Action {
        var shareToFriend = PassthroughSubject<Void,Never>()
        var exportToCalender = PassthroughSubject<Void,Never>()
        var shareToInstagram = PassthroughSubject<Void,Never>()
    }
    
    let action = Action()
    let state = State()
    
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
        
        action.shareToInstagram
            .sink(receiveValue: {
                InstagramShareHelper.shareToInstagram(event: event) { result in
                    if result == .fail {
                        self.state.showAlert.send("Instagram app is not installed")
                    }
                }
            }).store(in: &cancellables)
    }

}
