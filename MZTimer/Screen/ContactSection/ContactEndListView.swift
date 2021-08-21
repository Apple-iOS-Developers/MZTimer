//
//  PhoneBookEndListView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import SwiftUI
import ContactsUI

struct ContactEndListView: View {
    
    let flexibleLayout = [GridItem(.flexible()), GridItem(.flexible())]

    @Binding var address: [ContactModel]
    @State var showModal: Bool = false
    
    let pub = NotificationCenter.default.publisher(for: NSNotification.ContactSelected)

    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: flexibleLayout, spacing: 20) {
                    ForEach(address, id: \.self) {
                        PhoneBookRow(item: $0)
                    }
                }
                Spacer().frame(height:500)
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            .onReceive(pub) { (obj) in
                if let userInfo = obj.userInfo, let info = userInfo["contact"] {
                    let contact = info as! CNContact
                    let MobNumVar = (contact.phoneNumbers[0].value ).value(forKey: "digits") as! String
                    let newContact = ContactModel(name: contact.givenName, phoneNumber: MobNumVar, memo: contact.note)
                    address.append(newContact)
                    UserDefaultStorage.shared.saveContact(contact: newContact)
                    showModal.toggle()
                }
                self.loadData()
            }
        }
        .onAppear {
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { bool, error in
                
            }
        }
        .toolbar {
            Button("추가하기") {
                showModal.toggle()
            }
        }
        .sheet(isPresented: $showModal) {
            EmbeddedContactPicker()
        }
        .navigationBarTitle("공유할 친구들")
        
    }
    
    func loadData() {
        
    }
}

struct PhoneBookEndListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactEndListView(address: .constant([]))
    }
}
