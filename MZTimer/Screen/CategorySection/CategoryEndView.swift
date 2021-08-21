//
//  CategoryListView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI

struct CategoryEndView: View {

    let category: Category
    let totalTime: String
    let recentDate: String
    let totalCount: String
    let events: [Event]

    @ObservedObject var viewModel: ViewModel

    @State var emoji = ""
    @State var name = ""


    init(viewModel: ViewModel, category: Category) {
        self.viewModel = viewModel
        self.category = category
        self.events = viewModel.events.filter{ $0.title == category.title }
        self.totalTime = "\(UserDefaultStorage.shared.getTotalTime(category: category).convertTimeToString())"
        self.recentDate = "\(UserDefaultStorage.shared.getRecentEvent(category: category)?.endDate.dateWithTimeString() ?? "No recently done")"
        self.totalCount = "\(UserDefaultStorage.shared.getDoneCount(category: category) ?? 0)"
        self.emoji = category.emoji
        self.name = category.title

    }

    var body: some View {
        ScrollView {
            VStack(alignment:.leading, spacing: 10) {

                infoView()

                editView()

                Text("Event lists")
                relatedEventsView()

            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)
        .contentShape(Rectangle())
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .preferredColorScheme(.dark)
        .navigationTitle(category.titleWithEmoji())
        .onDisappear(perform: {
            if emoji.removeWhiteSpace() == "" || name.removeWhiteSpace() == "" { return }
            UserDefaultStorage.shared.updateCategory(before: category, after: Category(emoji: emoji, title: name))
        })
    }

    private func relatedEventsView() -> some View {
        return LazyVStack {
            ForEach( events, id:\.self) {
                EventRow(event: $0)
            }
        }.padding(.horizontal, 20)
    }
    private func infoView() -> some View {
        return VStack(alignment:.leading) {
            Text("Total count")
            TextField(totalCount, text: $emoji)
                .frame(height: 44, alignment: .center)
                .padding(.horizontal, 20)
                .background(Color.rowBackground)
                .cornerRadius(10)
                .disabled(true)

            Text("Total Time")
            TextField(totalTime, text: $emoji)
                .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 20)
                .background(Color.rowBackground)
                .cornerRadius(10)
                .disabled(true)

            Text("Done Recently")
            TextField(recentDate, text: $emoji)
                .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 20)
                .background(Color.rowBackground)
                .cornerRadius(10)
                .disabled(true)
        }
    }
    private func editView() -> some View {
        return VStack(alignment:.leading) {

            Text("Edit emoji")
            TextField(category.emoji, text: $emoji)
                .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 20)
                .background(Color.rowBackground)
                .cornerRadius(10)

            Text("Edit Name")
            TextField(category.title, text: $name)
                .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 20)
                .background(Color.rowBackground)
                .cornerRadius(10)

        }
    }
}

struct CategoryEndView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryEndView(viewModel: ViewModel(), category: Category(emoji: "😙", title: "밥먹고 똥싸기"))
    }
}
