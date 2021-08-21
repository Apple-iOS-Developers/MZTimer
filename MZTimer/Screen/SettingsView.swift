//
//  SettingsView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/06/12.
//

import SwiftUI

struct SettingsView: View {

    @State private var sendMessage: Bool = UserDefaults.standard.bool(forKey: "SendMessage")
    @State private var addCalender: Bool = UserDefaults.standard.bool(forKey: "AddCalender")
    @State private var userName: String = UserDefaults.standard.string(forKey: "UserName") ?? ""

    var body: some View {

        VStack(alignment:.leading) {

            Spacer().frame(height:50)

            Text("Settings").font(.largeTitle)

            Spacer().frame(height:50)

            VStack(alignment:.leading, spacing:0){
                Toggle(sendMessage ? "Text messaging enabled" : "Text messaging disabled", isOn: $sendMessage)
                    .onChange(of: sendMessage, perform: { value in
                        if sendMessage {
                            UserDefaults.standard.setValue(true, forKey: "SendMessage")
                        }else {
                            UserDefaults.standard.setValue(false, forKey: "SendMessage")
                        }
                    })
                Text("description").font(.caption).foregroundColor(.yellow)
                Text("When timer ends, app will automatically make message to share event to friends").font(.caption)

                Spacer().frame(height:10)

                Text("warning!").font(.caption).foregroundColor(.red)
                Text("If all receiver is using iMessage, \nmessage will send by creating group chat!").font(.caption)
            }
            .padding()
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)

            Spacer().frame(height:20)

            VStack(alignment:.leading, spacing:0){
                Toggle(addCalender ? "Calender adding enabled" : "Calender adding disabled", isOn: $addCalender)
                    .onChange(of: addCalender, perform: { value in
                        if addCalender {
                            UserDefaults.standard.setValue(true, forKey: "AddCalender")
                        }else {
                            UserDefaults.standard.setValue(false, forKey: "AddCalender")
                        }
                    })
                Text("description").font(.caption).foregroundColor(.yellow)
                Text("When timer ends, app will automatically add event to your default iCalender").font(.caption)
            }
            .padding()
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)

            VStack(alignment: .leading, spacing:0 ){
                
                Text("User name")
                TextField("사용자 이름", text: $userName)
                Text("description").font(.caption).foregroundColor(.yellow)
                Text("When sharing to friends, message will created by using this name").font(.caption)
            }

            Spacer()

        }
        .preferredColorScheme(.dark)
        .foregroundColor(.white)
        .padding()

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
