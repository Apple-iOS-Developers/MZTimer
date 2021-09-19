//
//  ContactEndView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import SwiftUI

struct ContactEndView: View {
    
    let contact: Contact
    
    init(contact: Contact){
        self.contact = contact
    }
    
    var body: some View {
        VStack{
            Text("\(contact.name)")
            Text("\(contact.phoneNumber)")
            Text("\(contact.memo)")
        }
    }
}

struct ContactEndView_Previews: PreviewProvider {
    static var previews: some View {
        ContactEndView(contact: Contact(name: "", phoneNumber: "", memo: ""))
    }
}
