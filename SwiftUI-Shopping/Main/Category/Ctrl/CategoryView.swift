//
//  CategoryView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .edgesIgnoringSafeArea(.bottom) // 隐藏底部安全区域，包括标签栏

    }
}

#Preview {
    CategoryView()
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
