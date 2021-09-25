//
//  MadeByView.swift
//  MZTimer
//
//  Created by TaeHyeong Kim on 2021/09/25.
//

import SwiftUI
import StoreKit

struct MadeByView: View {
    @State var bugReport: String = ""
    var body: some View {
        VStack {
            Spacer()
            
            Text("Made by TaeHyeongKim")
            
            Spacer()
            
            Text("Bug Report")
            TextField("write comment about bug or app", text: $bugReport)
                .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 20)
                .background(Color.rowBackground)
                .cornerRadius(10)
            
            Spacer()
            
            Button(action: {
               //
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
       
}

struct MadeByView_Previews: PreviewProvider {
    static var previews: some View {
        MadeByView()
    }
}
