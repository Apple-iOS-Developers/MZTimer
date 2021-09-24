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
    @State private var minimumTime: String = UserDefaults.standard.string(forKey: "MinimumTime") ?? "0"
    
    @State private var showAlert: Bool = false
    @State private var showWatchConnectivityResultAlarm = false
    @State private var watchConnectivityResult: WatchConnectivityResult = WatchConnectivityResult.isNotReachable
    
    @Binding var showSetting: Bool

    var body: some View {

        VStack(alignment:.leading) {

            Spacer().frame(height:50)

            Text("Settings").font(.largeTitle)

            Spacer().frame(height:50)
            
            VStack(alignment: .leading, spacing: 0 ){
                Text("Timer event Minimum time")
                TextField("Enter Minimum time to record event", text: $minimumTime)
                Text("description").font(.caption).foregroundColor(.yellow)
                Text("When event time is less than minimum time \nrecord will be ignored").font(.caption)
            }
            .padding()
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)

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
                Text("When timer ends, app will automatically \nmake message to share event to friends").font(.caption)

                Spacer().frame(height:10)

                Text("warning!").font(.caption).foregroundColor(.red)
                Text("If all receiver is using iMessage, \nmessage will send by creating group chat!").font(.caption)
            }
            .padding()
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)

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
            

            VStack(alignment: .leading, spacing: 0 ){
                Text("User name")
                TextField("Enter your name/nickname (Required)", text: $userName)
                Text("description").font(.caption).foregroundColor(.yellow)
                Text("When sharing to friends, message will created by using this name").font(.caption)
            }
            .padding()
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)


            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Text("Export Category data to apple watch")
                    Spacer()
                    Button(action: {
                        WatchManager.shared.syncDataToWatch { watchConnectivityResult in
                            showWatchConnectivityResultAlarm = true
                            self.watchConnectivityResult = watchConnectivityResult
                        }
                    }, label: {
                        Text("Export")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.green)
                            .cornerRadius(3)
                    })
                }
                Text("description").font(.caption).foregroundColor(.yellow)
                Text("Open companion watch app and press sync button").font(.caption)
            }
            .alert(isPresented: $showWatchConnectivityResultAlarm, content: {
                Alert(title: Text(watchConnectivityResult.rawValue))
            })
            .padding()
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)

            Spacer()


            Button(action: {
                if userName.isEmpty || userName == "" {
                    showAlert.toggle()
                } else {
                    UserDefaults.standard.setValue(userName, forKey: "UserName")
                    showSetting.toggle()
                }
            }, label: {
                Text("Save")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(width: UIScreen.main.bounds.width-40, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.green)
                    .cornerRadius(10)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("please enter your name."), dismissButton: .default(Text("ok")))
            }


        }
        .preferredColorScheme(.dark)
        .foregroundColor(.white)
        .padding()
        

    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSetting: .constant(true))
    }
}
