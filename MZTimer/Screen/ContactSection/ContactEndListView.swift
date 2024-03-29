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

    @Binding var address: [Contact]
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
                    guard let contact = info as? CNContact else { return }
                    if contact.phoneNumbers.count == 0 { return }//번호 없는 주소 추가했을 때
                    guard let MobNumVar = (contact.phoneNumbers[0].value).value(forKey: "digits") as? String else { return }
                    let newContact = Contact(name: contact.givenName, phoneNumber: MobNumVar, memo: contact.note)
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
            Button("add Friend") {
                showModal.toggle()
            }
        }
        .sheet(isPresented: $showModal) {
            EmbeddedContactPicker()
        }
        .navigationBarTitle("Sharing Friends")
        
    }
    
    func loadData() {
        
    }
}

struct PhoneBookEndListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactEndListView(address: .constant([]))
    }
}
