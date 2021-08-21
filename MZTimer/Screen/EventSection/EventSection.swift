//
//  EventSection.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI


struct Section: View {
    let title: String
    @ObservedObject var viewModel: ViewModel
    
    @State var pushListEnd: Bool = false
    var body: some View {
        VStack {
            HStack{
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                NavigationLink(
                    destination: EventListEndView(events: $viewModel.events),
                    isActive: $pushListEnd,
                    label: {
                        Text("more")
                            .contentShape(Rectangle())
                            .onTapGesture {
                                pushListEnd.toggle()
                            }
                    })
            }
            
            LazyVStack {
                ForEach( viewModel.events.count > 3 ? viewModel.events.suffix(3).reversed() : viewModel.events.reversed(), id: \.self) {
                    EventRow(event: $0)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
    }
}
