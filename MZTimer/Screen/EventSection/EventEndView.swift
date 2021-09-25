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
    
    @State var startDate: Date
    @State var endDate: Date
    
    var body: some View {
        VStack(spacing:20) {
            
            Spacer()
            VStack(alignment:.center, spacing:10){
                HStack(alignment:.center) {
                    Text(viewModel.event.emoji).font(.system(size: 60))
                    Text(viewModel.event.title).font(.largeTitle)
                }
                
                Text("Total: \(Int(endDate.timeIntervalSince(startDate)).convertTimeToString())").font(.system(size: 20))
                    .bold()
                
                Form {
                    DatePicker("Start Date", selection: $startDate, in: ...endDate)
                    DatePicker("End Date", selection: $endDate, in: startDate...)
                    Button {
                        let newEvent = Event(emoji: viewModel.event.emoji, title: viewModel.event.title, time: Int(endDate.timeIntervalSince(startDate)), endDate: endDate)
                        UserDefaultStorage.shared.updateEvent(before: viewModel.event, after: newEvent)
                    } label: {
                        Text("save")
                    }
                }
            }



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
        let viewModel = EventEndViewModel(event: Event(emoji: "🥯", title: "빵먹기", time: 100, startDate: Date()))
        EventEndView(viewModel: viewModel, startDate: viewModel.event.startDate, endDate: viewModel.event.endDate)
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
                DispatchQueue.main.async {
                    guard let url = URL(string: "calshow://") else { return }
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
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
