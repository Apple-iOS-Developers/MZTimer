//
//  TimerView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/06/12.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("현재 진행중인 과제")
                .underline()
                .foregroundColor(.white)
            Spacer()
            HStack {
                Text("0")
                Text("0")
                Text(":")
                Text("0")
                Text("0")
                Text(":")
                Text("0")
                Text("0")
            }
            .font(.system(size: 70))
            .foregroundColor(.white)

            Spacer()

            HStack(spacing:0) {
                Button(action: {}, label: {
                    Text("중지").font(.title).foregroundColor(.yellow).bold()
                })
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 60, maxHeight: 60, alignment: .center)

                Button(action: {}, label: {
                    Text("시작").font(.title).foregroundColor(.green).bold()
                })
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 60, maxHeight: 60, alignment: .center)

                Button(action: {}, label: {
                    Text("종료").font(.title).foregroundColor(.red).bold()
                })
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 60, maxHeight: 60, alignment: .center)


            }
            .padding(.top, 20)
            .foregroundColor(.white)

        }
        .frame(height: 300)
        .padding()
        .preferredColorScheme(.dark)

    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView().background(Color.black)
    }
}
