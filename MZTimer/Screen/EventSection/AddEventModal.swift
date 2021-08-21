//
//  AddEventModal.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import SwiftUI

struct AddEventModal: View {
    @State var title: String = ""
    @State var category: String = ""
    @Binding var showModal: Bool
    @Binding var event: [Event]
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading, spacing:10) {
                Spacer()
                Text("Category emoji")
                TextField("Add new Category emoji", text: $title)
                    .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 20)
                    .background(Color.rowBackground)
                    .cornerRadius(10)
                
                
                Text("Category name")
                    .padding(.top, 30)
                TextField("Add new category name", text: $category)
                    .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 20)
                    .background(Color.rowBackground)
                    .cornerRadius(10)
                
                Button(action: {
                    let newEvent = Event(emoji: "🔍", title: "독서", time: 10, startDate: Date())
                    event.append(newEvent)
                    UserDefaultStorage.shared.saveEvent(event: newEvent)
                    showModal.toggle()
                }, label: {
                    Text("Confirm").foregroundColor(.white).font(.title)
                        .frame(width: UIScreen.main.bounds.width-40, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.top, 100)
                
                
                Spacer().frame(height:200)
                
                
            }.padding(.horizontal, 20)
            .frame(height:600)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .preferredColorScheme(.dark)
    }
}

struct AddEventModal_Previews: PreviewProvider {
    static var previews: some View {
        AddEventModal(showModal: .constant(false), event: .constant([]))
    }
}
