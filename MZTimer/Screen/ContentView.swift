//
//  ContentView.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/05/29.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    @ObservedObject var viewModel = ViewModel()
    @ObservedObject var timerViewModel = TimerViewModel()
    @ObservedObject var categoryListEndViewModel = CategoryListEndViewModel()

    @State var showCategorySheet = false
    @State var isStopPressed = false
    @State var showSetting = false
    @State var showSettingFullScreen = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                ScrollView(showsIndicators: false) {
                    
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        viewModel.reloadData()
                        print("refresh data")
                    }
                    
                    VStack {
                        Spacer().frame(height:100)

                        VStack {

                            addCurrentObjectView()

                            Spacer()

                            addTimeTextView()

                            Spacer()

                            addButtonsView()

                        }
                        .frame(height: 300)
                        .padding()

                        addRecordSection()

                        addCategoryGridSection()

                        addPhoneBookSection()

                        addFooterView()

                    }
                }
                .padding(safeAreaInsets)
                .coordinateSpace(name: "pullToRefresh")
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("⏱MZ Timer")
            
        }
        .preferredColorScheme(.dark)
        .onAppear(perform: {
            _ = WatchManager.shared
            checkInitialLaunch()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    func addCurrentObjectView() -> some View {
        HStack{
            Text(viewModel.currentObject)
            Spacer()
        }
    }

    func addTimeTextView() -> some View {
        HStack {
            Text("\(timerViewModel.hours)")
            Text(":")
            Text("\(timerViewModel.minutes)")
            Text(":")
            Text("\(timerViewModel.seconds)")
        }
        .font(.system(size: 60))
    }

    func addButtonsView() -> some View {
        HStack(spacing:0) {

            Button(action: {
                timerViewModel.isPaused && categoryListEndViewModel.categorySelected() ? timerViewModel.resume() : timerViewModel.pause()
            }, label: {
                if categoryListEndViewModel.categorySelected() {
                    Text(timerViewModel.isPaused ? "Resume" : "Pause").font(.title).foregroundColor(.yellow).bold()
                }else {
                    Text("Pause").font(.title).foregroundColor(.yellow).bold()
                }
            })
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 60, maxHeight: 60, alignment: .center)

            Button(action: {
                showCategorySheet.toggle()
            }, label: {
                Text("Start").font(.title).foregroundColor(.green).bold()
            })
            .sheet(isPresented: $showCategorySheet, onDismiss: {
                if categoryListEndViewModel.categorySelected() {
                    timerViewModel.start(category: categoryListEndViewModel.selectedCategory)
                    viewModel.currentObject = categoryListEndViewModel.selectedCategory.titleWithEmoji()
                }
            }, content: {
                CategoryListEndView(categoryEndviewModel: categoryListEndViewModel, viewModel: viewModel, showCategorySheet: $showCategorySheet, pushEnable: false)
            })
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 60, maxHeight: 60, alignment: .center)

            Button(action: {
                categoryListEndViewModel.categorySelected() ? isStopPressed.toggle() : nil
            }, label: {
                Text("Stop").font(.title).foregroundColor(.red).bold()
            })
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 60, maxHeight: 60, alignment: .center)
            .actionSheet(isPresented: $isStopPressed, content: {
                ActionSheet(
                    title: Text("End event"),
                    message: Text("Confirm end current event"),
                    buttons: [
                        ActionSheet.Button.default(Text("Confirm"), action: {
                            timerViewModel.stop()
                            categoryListEndViewModel.resetSelectedCategory()
                            viewModel.reloadData()
                            viewModel.currentObject = "There are currently no events"
                        }), .cancel(Text("Cancel"))
                    ]
                )

            })
        }
        .padding(.top, 20)
        .foregroundColor(.white)
    }

    func addRecordSection() -> some View {
        Section(title: "Recent Event", viewModel: viewModel)
    }

    func addCategoryGridSection() -> some View {
        CategoryGridView(viewModel: viewModel, categoryListEndViewModel: categoryListEndViewModel, title: "Category")
    }

    func addPhoneBookSection() -> some View {
        ContactSection(title: "Friends", viewModel: viewModel)
    }

    func addFooterView() -> some View {
        HStack {
            Spacer()

            Button(action: {
                showSetting.toggle()
            }, label: {
                Text("Settings")
            })
            .fullScreenCover(isPresented: $showSettingFullScreen, content: {
                SettingsView(showSetting: $showSettingFullScreen)
            })
            .sheet(isPresented: $showSetting, content: {
                SettingsView(showSetting: $showSetting)
            })

            Spacer()

            Button(action: {}, label: {
                Text("made by")
            })

            Spacer()
        }.padding(.vertical, 30)
        .font(.body)
    }
    
    func checkInitialLaunch() {
        if UserDefaults.standard.bool(forKey: "initialLaunch") == false || UserDefaults.standard.string(forKey: "UserName") == nil {
            UserDefaults.standard.setValue(true, forKey: "initialLaunch")
            UserDefaults.standard.setValue("5", forKey: "MinimumTime")
            showSettingFullScreen.toggle()
        }
    }
}

struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Text("⬇️")
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
