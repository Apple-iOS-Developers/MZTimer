//
//  AddCategoryModal.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI

struct AddCategoryModal: View {
    @State var emoji: String = ""
    @State var name: String = ""

    @Binding var showModal: Bool
    @ObservedObject var viewModel: CategoryListEndViewModel

    var body: some View {
        ScrollView{
            VStack(alignment:.leading, spacing:10) {
                Spacer()
                Text("Category emoji")
                TextField("Add new emoji", text: $emoji)
                    .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 20)
                    .background(Color.rowBackground)
                    .cornerRadius(10)
                
                
                Text("Category Name")
                    .padding(.top, 30)
                TextField("Add new Category name", text: $name)
                    .frame(height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 20)
                    .background(Color.rowBackground)
                    .cornerRadius(10)
                
                Button(action: {
                    if emoji == "" || name == "" {
                        return
                    }
                    let newCategory = Category(emoji: emoji, title: name)
                    if UserDefaultStorage.shared.checkCategoryDuplicated(category: newCategory) { showModal = false }
                    viewModel.category.append(newCategory)
                    UserDefaultStorage.shared.saveCategory(category: newCategory)
                    showModal = false
                }, label: {
                    Text("Confirm").foregroundColor(.white).font(.title)
                        .frame(width: UIScreen.main.bounds.width-40, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.top, 100)
                
                
                Spacer().frame(height:200)
                
                
            }.padding(.horizontal, 20)
            .frame(height:600)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .preferredColorScheme(.dark)

    }
}

struct AddCategoryModal_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryModal(showModal: .constant(false), viewModel: CategoryListEndViewModel())
            .preferredColorScheme(.dark)
    }
}

