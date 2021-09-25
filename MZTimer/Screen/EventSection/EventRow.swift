//
//  EventRow.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/06/13.
//

import SwiftUI

struct EventRow: View {
    let event : Event
    init(event: Event) {
        self.event = event
    }
    @State var pushEndView: Bool = false
    @State var longPressed = false
    
    var body: some View {
        NavigationLink(
            destination: EventEndView(viewModel: EventEndViewModel(event: event), startDate: event.startDate, endDate: event.endDate),
            isActive: $pushEndView,
            label: {
                VStack {
                    HStack {
                        Text(event.emoji).font(.system(size: 40))
                            .frame(width: 80, height: 80, alignment: .center)
                        VStack(alignment: .leading, spacing: 5) {

                            Text(event.title)
                                .font(.headline)
                                .foregroundColor(.rowTitle)

                            HStack(alignment:.bottom){
                                Text("\(event.time.convertTimeToString())")
                                    .font(.title)
                                    .foregroundColor(.textGreen)
                                Spacer()
                                Text("\(event.startDate.dateWithoutTimeString())")
                                    .font(.caption)
                                    .padding(.trailing, 10)
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                    }
                    .background(Color.rowBackground)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)

                }
                .frame(width: UIScreen.main.bounds.width, height: 80, alignment: .center)
                .contentShape(Rectangle())
                .onTapGesture {
                    pushEndView.toggle()
                }
                .onLongPressGesture {
                    longPressed.toggle()
                }
                .actionSheet(isPresented: $longPressed, content: {
                    ActionSheet(
                        title: Text("Delete Event"),
                        message: Text("Confirm deleting \(event.title)?"),
                        buttons: [
                            ActionSheet.Button.default(Text("Delete"), action: {
                                UserDefaultStorage.shared.removeEvent(event: event)
                            }), .cancel(Text("Cancel"))
                        ]
                    )
                })
            })
    }

}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: Event(emoji: "", title: "", time: 0, endDate: Date()))
    }
}
