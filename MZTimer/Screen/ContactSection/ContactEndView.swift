//
//  ContactEndView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/30.
//

import SwiftUI

struct ContactEndView: View {
    
    let contact: ContactModel
    
    init(contact: ContactModel){
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
        ContactEndView(contact: ContactModel(name: "", phoneNumber: "", memo: ""))
    }
}
