//
//  ContentView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//
//

import SwiftUI
import Toast_Swift
  
enum Tab: String, Identifiable {
    case home
    case profile
    case settings
    case mine
    
    var id: String { self.rawValue }
}
  
struct ContentView: View {
    
    @State var shouldLoadView2 = false
    @State var shouldLoadView3 = false
    @State var shouldLoadView4 = false

    @State var op1 = 1.0
    @State var op2 = 0.0
    @State var op3 = 0.0
    @State var op4 = 0.0
    
    @State private var selectedTab = Tab.home
      
    @State private var isCurrentPage = true
    
    var body: some View {
        
        let hView = HomeView(isCurrentPage: $isCurrentPage)
         let cView = CategoryView(isCurrentPage: $isCurrentPage)
         let cartV = CartView(isCurrentPage: $isCurrentPage)
         let mView = MineView(isCurrentPage: $isCurrentPage)
        
        ZStack {
            
//            NavigationView{
               
                VStack{
                    
                    ZStack{
                        
                        
                        hView
                            .opacity(op1)
                        
                        if(shouldLoadView2){
                            
                            
                            cView
                            .opacity(op2)
                        }
                        if(shouldLoadView3){
                            
                            
                            cartV
                            .opacity(op3)
                        }
                        if(shouldLoadView4){
                            
                            
                            mView
                            .opacity(op4)
                        }
                        
                        
                    }
                    
                    Spacer()
                    
                    Group {
                        
                        if self.isCurrentPage{
                            
                            // 标签栏视图
                            HStack {
                                Spacer()
                                
                                TabButton(tab: Tab.home, isSelected: selectedTab == Tab.home) {
                                    op1 = 1.0
                                    op2 = 0.0
                                    op3 = 0.0
                                    op4 = 0.0
                                    selectedTab = Tab.home
                                }
                                Spacer()
                                TabButton(tab: Tab.profile, isSelected: selectedTab == Tab.profile) {
                                    op2 = 1.0
                                    op1 = 0.0
                                    op3 = 0.0
                                    op4 = 0.0
                                    shouldLoadView2 = true
                                    selectedTab = Tab.profile
                                }
                                Spacer()
                                TabButton(tab: Tab.settings, isSelected: selectedTab == Tab.settings) {
                                    op3 = 1.0
                                    op2 = 0.0
                                    op1 = 0.0
                                    op4 = 0.0
                                    shouldLoadView3 = true
                                    selectedTab = Tab.settings
                                }
                                Spacer()
                                TabButton(tab: Tab.mine, isSelected: selectedTab == Tab.mine) {
                                    op4 = 1.0
                                    op2 = 0.0
                                    op3 = 0.0
                                    op1 = 0.0
                                    shouldLoadView4 = true
                                    selectedTab = Tab.mine
                                }
                                Spacer()
                            }
                            .padding(.bottom) // 将标签栏放在底部
                            .frame(height: 60) // 设置标签栏的高度a
                        }
                    }
                }
            
        }.onAppear(){
            
            
        }
        .onDisappear(){
            
            
        }
    }
}
  
struct TabButton: View {
    let tab: Tab
    let isSelected: Bool
    let action: () -> Void
      
    var body: some View {
        Button(action: action) {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Image(systemName: self.imageName)
                    .renderingMode(.template)
                    .foregroundColor(isSelected ? .blue : .gray)
                    .frame(width: 25,height: 25)
                    .font(.system(size: 24))
                Text(self.title)
                    .foregroundColor(isSelected ? .blue : .gray)
                    .font(.system(size: 18))
            }
            .padding()
        }
    }
      
    private var title: String {
        switch tab {
        case .home: return "首页"
        case .profile: return "分类"
        case .settings: return "购物车"
        case .mine:return "我的"
        }
    }
      
    private var imageName: String {
        switch tab {
        case .home: return "house.fill"
        case .profile: return "basketball.circle"
        case .settings: return "cart"
        case .mine: return "person"
            
        }
    }
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
