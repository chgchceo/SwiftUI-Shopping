//
//  ContentView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//
//

import SwiftUI
  
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
            // 内容视图，根据 selectedTab 切换
            if selectedTab == Tab.home {
                
                NavigationView{
                    
                    HomeView()
                }
            } else if selectedTab == Tab.profile {
                Text("Profile Content")
            } else if selectedTab == Tab.settings {
                Text("Settings Content")
            }else if selectedTab == Tab.mine{
                
                
            }
            
            VStack{
                
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
//            .background(isSelected ? Color(UIColor.systemBlue).cornerRadius(8) : nil)
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
        case .profile: return "person.circle.fill"
        case .settings: return "cart"
        case .mine: return "person"
            
        }
    }
}



//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//   
//    var body: some View {
//        
//        TabView{
//            HomeView()
//                .tabItem {
//                    Image(systemName: "sun.min")
//                    Text("首页")
//                        .font(.system(size: 15))
//                }
//            Text("2")
//                .tabItem {
//                    Image(systemName: "wifi")
//                    Text("分类")
//                    
//                }
//            Text("3")
//                .tabItem {
//                    Image(systemName: "cart")
//                    Text("购物车")
//                    
//                }
//            Text("4")
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("我的")
//                    
//                }
//                .badge(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//        }
//        .tabViewStyle(.automatic)
//            .tint(Color.red)
//              .onAppear {
//                UITabBar.appearance().unselectedItemTintColor = .systemBrown
//                UITabBarItem.appearance().badgeColor = .green
//                UITabBar.appearance().backgroundColor = .groupTableViewBackground
//                UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
//                UITabBarItem.appearance().setBadgeTextAttributes([.foregroundColor: UIColor.red, .font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
//                UITabBarItem.appearance().setBadgeTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
//              }
//          
//    }
//
//}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
