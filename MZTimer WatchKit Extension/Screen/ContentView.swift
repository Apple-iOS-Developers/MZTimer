//
//  ContentView.swift
//  MZTimer WatchKit Extension
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {

    @ObservedObject var viewModel: WatchViewModel

    var body: some View {


        VStack(alignment:.leading) {
            Text("Category")
                .bold()
                .padding(.horizontal,10)
                .foregroundColor(Color.rowTitle)

            Spacer()

            ScrollView{
                LazyVStack(alignment:.leading, spacing:10) {
                    ForEach(viewModel.categories, id: \.self) {
                        CategoryRow(category: $0)
                    }
                }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WatchViewModel())
    }
}

struct CategoryRow: View {

    private let category: Category

    @State private var pushTimer: Bool = false

    init(category: Category) {
        self.category = category
    }

    var body: some View {
            NavigationLink(
                destination: TimerView(pushTimer: $pushTimer, timerViewModel: WatchTimerViewModel(currentCategory: category)),
                isActive: $pushTimer,
                label: {
                    HStack(alignment:.bottom, spacing: 5) {
                        Text(category.emoji).font(.largeTitle)
                        Text(category.title).font(.body).foregroundColor(Color.textGreen)
                        Spacer()
                    }
                    .frame(
                        width: WKInterfaceDevice.currentResolution == .watch38mm ? 136: 156,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                    )
                    .cornerRadius(10)
                    .padding(.horizontal,10)
                    .onTapGesture {
                        pushTimer.toggle()
                    }
                })

        }
}

enum WatchType {
    case watch38mm, watch42mm
}

extension WKInterfaceDevice {
    
    class var currentResolution: WatchType {
        // Apple Watch 38mm 136x170 - 42mm 156x195
        return WKInterfaceDevice.current().screenBounds.width == 136 ? .watch38mm : .watch42mm
    }
    
}
