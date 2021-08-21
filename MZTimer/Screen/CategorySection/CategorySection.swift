//
//  CategorySection.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI

struct CategoryGridView: View {

    @ObservedObject var viewModel: ViewModel
    @ObservedObject var categoryListEndViewModel: CategoryListEndViewModel
    
    var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible())]
    let title: String
    @State var pushListEnd: Bool = false {
        didSet {
            viewModel.categories = UserDefaultStorage.shared.loadCategory()
        }
    }

    var body: some View {
        VStack {
            HStack{
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                NavigationLink(
                    destination: CategoryListEndView(categoryEndviewModel: CategoryListEndViewModel(), viewModel: viewModel, showCategorySheet: .constant(false), pushEnable: true),
                    isActive: $pushListEnd,
                    label: {
                        Text("more")
                            .contentShape(Rectangle())
                            .onTapGesture {
                                pushListEnd.toggle()
                            }
                    })
            }

            LazyVGrid(columns: flexibleLayout, spacing: 20) {
                ForEach(viewModel.categories, id: \.self) {
                    CategoryRow(viewModel: viewModel, item: $0, pushEnable: true)
                }
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
        
    }
}
