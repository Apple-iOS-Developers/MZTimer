//
//  CategoryRow.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/06/12.
//

import SwiftUI

struct CategoryRow: View {
    @State var pushEndView: Bool = false
    @State var longPressed: Bool = false
    @ObservedObject var viewModel: ViewModel
    let item : Category
    let pushEnable: Bool
    init(viewModel: ViewModel, item: Category, pushEnable: Bool){
        self.item = item
        self.pushEnable = pushEnable
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationLink(
            destination: CategoryEndView(viewModel: viewModel, category: item),
            isActive: $pushEndView,
            label: {
                Text("\(item.titleWithEmoji())")
                    .font(.body)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                    .background(Color.rowBackground)
                    .contentShape(Rectangle())
                    .cornerRadius(10)
                    .onTapGesture {
                        pushEnable ? pushEndView.toggle() : nil
                    }
                    .onLongPressGesture {
                        pushEnable ? longPressed.toggle() : nil
                    }
                    .actionSheet(isPresented: $longPressed, content: {
                        ActionSheet(
                            title: Text("Delete Category"),
                            message: Text("confirm deleting \(item.title)?"),
                            buttons: [
                                ActionSheet.Button.default(Text("Delete"), action: {
                                    deleteCategory(category: item)
                                }), .cancel(Text("Cancel"))
                            ]
                        )

                    })
            })
    }
    private func deleteCategory(category: Category) {
        UserDefaultStorage.shared.removeCategory(category: category)
    }
}


struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(viewModel: ViewModel(), item: Category(emoji: "", title: ""), pushEnable: false)
    }
}
