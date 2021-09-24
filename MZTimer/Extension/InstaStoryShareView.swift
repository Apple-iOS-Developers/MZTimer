//
//  InstaStoryShareView.swift
//  MZTimer
//
//  Created by TaeHyeong Kim on 2021/09/25.
//

import SwiftUI

struct InstaStoryShareView: View {
    
    let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    var body: some View {
        
        
        ZStack() {
            VStack {
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
                
                HStack {
                    logoImage
                    logoImage
                    logoImage
                    logoImage
                }
            }
            
            VStack {
                HStack(alignment:.center) {
                    Text(event.emoji).font(.system(size: 60))
                    Text(event.title).font(.largeTitle)
                }
                
                VStack(alignment:.center, spacing:10){
                    Text("Total: \(event.time.convertTimeToString())").font(.system(size: 20))
                        .bold()
                    Text("start: \(event.startDate.dateWithTimeString())")
                    Text("end: \(event.endDate.dateWithTimeString())")
                }
            }
            .background(Color.black)
            .cornerRadius(10)
        
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("From MZTimer").bold()
                    Spacer().frame(width:20)
                }
                Spacer().frame(height:UIScreen.main.bounds.height/4)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .preferredColorScheme(.dark)

        
        
    }
    
    private var logoImage: some View {
        Image(uiImage: UIImage(named: "logo") ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .opacity(0.3)
    }
}

struct InstaStoryShareView_Previews: PreviewProvider {
    static var previews: some View {
        InstaStoryShareView(event: Event(emoji: "🕠", title: "수업 참여하기", time: 1000, endDate: Date()))
    }
}
