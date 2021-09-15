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
            Text("할일")
                .bold()
                .padding(.horizontal,10)
                .foregroundColor(Color.rowTitle)
            
            Spacer()
            
            ScrollView{
                LazyVStack(alignment:.leading, spacing:10) {
                    ForEach(viewModel.category, id: \.self) {
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
    let category: Category
    @State var pushTimer: Bool = false
    init(category: Category) {
        self.category = category
    }
    var body: some View {
        NavigationLink(
            destination: TimerView(pushTimer: $pushTimer),
            isActive: $pushTimer,
            label: {
                HStack(alignment:.bottom) {
                    Text(category.emoji).font(.largeTitle)
                    Text(category.title).font(.body).foregroundColor(Color.textGreen)
                }
                .frame(
                    width: WKInterfaceDevice.currentResolution == .watch38mm ? 136: 156,
                    alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                )
//                .background(Color.rowBackground)
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
