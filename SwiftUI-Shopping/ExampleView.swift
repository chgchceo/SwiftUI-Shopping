//
//  ExampleView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/28.
//

import SwiftUI

//enum Tab: String, Identifiable {
//  case home
//  case profile
//  case settings
//  case mine
//  
//  var id: String { self.rawValue }
//}

struct ExampleView: View {
    
   
    @State var text: String = ""
    @State private var selectedTab = Tab.home
    
    var body: some View {
        
        NavigationView(content: {
            
            UIKitTabView([
                UIKitTabView.Tab(view: NavView(), title: "首页", image: "phone32.png"),
                
                
                    
                UIKitTabView.Tab(view: HomeView(), title: "其他", image: "")
                
                
            ])
            .navigationBarTitle("其它", displayMode: .inline)
            
            
        })
        
    }
}
 
struct NavView: View {
    var body: some View {
        
        VStack {
            NavigationLink(destination: Text("您能看到这个页面，则证明bug修复").navigationBarTitle("Detail", displayMode: .inline)
                .navigationBarHidden(false)
                
            
            ) {
                Text("显示详细页")
                   
            }.navigationBarTitle("首页", displayMode: .inline)
            
        }
    }
}


#Preview {
    ExampleView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
