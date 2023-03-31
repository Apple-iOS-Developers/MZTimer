//
//  MadeByView.swift
//  MZTimer
//
//  Created by TaeHyeong Kim on 2021/09/25.
//

import SwiftUI
import StoreKit

struct MadeByView: View {
    
    @Binding var showMadeBy: Bool
    
    @State var bugReport: String = ""
    
    @State private var email: String = ""
    @State private var title: String = ""
    @State private var comment: String = " "
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Text("Made by KimTH").bold()
                Text("Bug report")
                HStack{
                    Text("email").frame(width:50)
                    TextField("your email", text: $email)
                        .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 20)
                        .background(Color.rowBackground)
                        .cornerRadius(10)
                }
                
                HStack{
                    Text("title").frame(width:50)
                    TextField("title of issue", text: $title)
                        .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 20)
                        .background(Color.rowBackground)
                        .cornerRadius(10)
                }
                VStack(alignment:.leading) {
                    Text("comment")
                    ZStack{
                        TextEditor(text:$comment).cornerRadius(10).background(Color.rowBackground).cornerRadius(10)
                        Text(comment).opacity(0).padding(.all,8)
                    }
                }
            } .alert(isPresented: $showAlert, content: {
                Alert(title: Text("can't send bug report. \nPlease fill out all fields"))
            })
            
            Button(action: {
                self.sendIssue()
            }, label: {
                Text("Send").foregroundColor(.white).font(.title)
                    .frame(width: UIScreen.main.bounds.width-40, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button(action: {
                if let scene = UIApplication.shared.windows.first?.windowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
                
            }, label: {
                Text("Review this app").foregroundColor(.white).font(.title)
                    .frame(width: UIScreen.main.bounds.width-40, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
        }
        .preferredColorScheme(.dark)
        .foregroundColor(.white)
        .padding()
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
    private func sendIssue() {
        
        
        if title.isEmpty || comment.isEmpty || email.isEmpty {
            showAlert = true
            return
        }
        guard let url = URL(string: "https://api.github.com/repos/Apple-iOS-Developers/MZTimer/issues") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let paramter: [String : Any] = ["title" : title, "body" : comment , "labels" : [email]]
        let jsonData = try? JSONSerialization.data(withJSONObject: paramter)
        request.httpBody = jsonData
        request.allHTTPHeaderFields = ["Authorization" : "",
                                       "Content-Type" : "application/josn"]
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 201 {
                    print("success")
                    showMadeBy = false
                } else {
                    showAlert = true
                    print("fail")
                }
            }
        }.resume()
    }
}

struct MadeByView_Previews: PreviewProvider {
    static var previews: some View {
        MadeByView(showMadeBy: .constant(false))
    }
}
