//
//  EventListEndView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI

struct EventListEndView: View {
    
    @Binding var events: [Event]
    @State var showModal: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach( events, id: \.self) {
                    EventRow(event: $0)
                }
            }
            Spacer().frame(height: 200)
        }
        .toolbar {
//            Button("추가하기") {
//                showModal.toggle()
//            }
        }
        .sheet(isPresented: $showModal) {
            AddEventModal(showModal: $showModal, event:$events)
        }
        .navigationBarTitle("All records")
    
    }
}

struct EventListEndView_Previews: PreviewProvider {
    static var previews: some View {
        EventListEndView(events: .constant([]))
    }
}
