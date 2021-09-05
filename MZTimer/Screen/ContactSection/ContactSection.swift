//
//  PhoneBookSection.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import SwiftUI

struct ContactSection: View {
    let title: String
    @ObservedObject var viewModel: ViewModel
    @State var showModal: Bool = false
    @State var pushListEnd: Bool = false
    var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            HStack{
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                
                NavigationLink(
                    destination: ContactEndListView(address: $viewModel.contacts),
                    isActive: $pushListEnd,
                    label: {
                        Text("more")
                            .contentShape(Rectangle())
                            .onTapGesture {
                                pushListEnd.toggle()
                            }
                    })
            }

            LazyVGrid(columns: flexibleLayout, spacing: 20) {
                ForEach(viewModel.contacts, id: \.self) {
                    PhoneBookRow(item: $0)
                }
            }

        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
        
    }
    
}

struct PhoneBookSection_Previews: PreviewProvider {
    static var previews: some View {
        ContactSection(title: "AEfaef", viewModel: ViewModel())
    }
}


struct PhoneBookRow: View {
    @State var pushEndView: Bool = false
    @State var longPressed: Bool = false
    let item : ContactModel
    
    init(item: ContactModel){
        self.item = item
    }
    var body: some View {
        NavigationLink(
            destination: ContactEndView(contact: item),
            isActive: $pushEndView,
            label: {
                Text("\(item.name)")
                    .font(.body)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                    .background(Color.rowBackground)
                    .contentShape(Rectangle())
                    .cornerRadius(10)
                    .onTapGesture {
                        pushEndView.toggle()
                    }
                    .onLongPressGesture {
                        longPressed.toggle()
                    }
                    .actionSheet(isPresented: $longPressed, content: {
                        ActionSheet(
                            title: Text("Delete Friends from share list"),
                            message: Text("Confirm deleting\(item.name) from share list"),
                            buttons: [
                                ActionSheet.Button.default(Text("Delete"), action: {
                                    deleteContact(contact: item)
                                }), .cancel(Text("Cancel"))
                            ]
                        )
                        
                    })
            })
    }
    
    private func deleteContact(contact: ContactModel) {
        UserDefaultStorage.shared.removeContact(contact: contact)
    }
}
