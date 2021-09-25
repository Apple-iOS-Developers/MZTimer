//
//  CategoryListEndView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI
import Combine

enum ScreenFrom {
    case home
    case end
}

struct CategoryListEndView: View {

    @ObservedObject var categoryEndviewModel : CategoryListEndViewModel
    @ObservedObject var viewModel: ViewModel
    @State var showModal : Bool = false
    @Binding var showCategorySheet : Bool
    var pushEnable: Bool
    var body: some View {
        ScrollView {
            VStack {
                addGridView()
                Spacer().frame(height:500)
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
        }
        .toolbar {
            Button("new Item") {
                showModal.toggle()
            }
        }
        .sheet(isPresented: $showModal) {
            AddCategoryModal(showModal: $showModal,viewModel: categoryEndviewModel)
        }
        .navigationBarTitle("All Category")
        .preferredColorScheme(.dark)
    }

    private func addGridView() -> some View {
        LazyVGrid(columns: categoryEndviewModel.flexibleLayout, spacing: 20) {
            ForEach(categoryEndviewModel.categories, id: \.self) { category in
                ZStack {
                    CategoryRow(viewModel: viewModel, item: category, pushEnable: pushEnable)
                    if !pushEnable {
                        Rectangle()
                            .fill(Color.black.opacity(0.01))
                            .onTapGesture {
                                categoryEndviewModel.selectedCategory = category
                                showCategorySheet.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct CategoryListEndView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListEndView(categoryEndviewModel: CategoryListEndViewModel(), viewModel: ViewModel(), showCategorySheet: .constant(false), pushEnable: true)
            .preferredColorScheme(.dark)
    }
}

class CategoryListEndViewModel: NSObject, ObservableObject {

    var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible())]
    @Published var showModal: Bool = false
    @Published var selectedCategory: Category = Category(emoji: "", title: "")
    @Published var categories: [Category] = []
    
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        categories = UserDefaultStorage.shared.loadCategory()
        NotificationCenter.default.addObserver(self, selector: #selector(didAppBecomeForegorundReceived), name: .AppEnterForeground, object: nil)
        
        NotificationCenter.default.publisher(for: .CategoryUpdated).sink { _ in
            self.reloadCategories()
        }.store(in: &cancellables)
    }

    func resetSelectedCategory() {
        selectedCategory = Category(emoji: "", title: "")
    }

    func categorySelected() -> Bool {
        return selectedCategory.titleWithEmoji() == " " ? false : true
    }
    
    @objc func didAppBecomeForegorundReceived(_ notification: Notification) {
        if let eventInfo = notification.userInfo?["event"] as? Event {
            selectedCategory = Category(emoji: eventInfo.emoji, title: eventInfo.title)
        }
    }
    
    private func reloadCategories(){
        categories.removeAll()
        categories = UserDefaultStorage.shared.loadCategory()
    }
}
