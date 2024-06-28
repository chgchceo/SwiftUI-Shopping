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
    @State private var selectedTab = Tab.home
      
    var body: some View {
        
        ZStack {
            
            NavigationView{
               
                VStack{
                    // 内容视图，根据 selectedTab 切换
                    if selectedTab == Tab.home {
                        
                        HomeView()
                        
                    } else if selectedTab == Tab.profile {
                        
                        CategoryView()
                    } else if selectedTab == Tab.settings {
                        
                        CartView()
                    }else if selectedTab == Tab.mine{
                        
                        MineView()
                    }
                    
                    Spacer()
                    // 标签栏视图
                    HStack {
                        Spacer()
                        
                        TabButton(tab: Tab.home, isSelected: selectedTab == Tab.home) {
                            selectedTab = Tab.home
                        }
                        Spacer()
                        TabButton(tab: Tab.profile, isSelected: selectedTab == Tab.profile) {
                            selectedTab = Tab.profile
                        }
                        Spacer()
                        TabButton(tab: Tab.settings, isSelected: selectedTab == Tab.settings) {
                            selectedTab = Tab.settings
                        }
                        Spacer()
                        TabButton(tab: Tab.mine, isSelected: selectedTab == Tab.mine) {
                            selectedTab = Tab.mine
                        }
                        Spacer()
                    }
                    .padding(.bottom) // 将标签栏放在底部
                    .frame(height: 50) // 设置标签栏的高度a
                    .background(.white)
                }
            }
            
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

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
