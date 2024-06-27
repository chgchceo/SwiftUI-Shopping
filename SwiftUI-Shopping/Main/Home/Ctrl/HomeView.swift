//
//  HomeView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ZStack{
            
            //背景颜色
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(20)
            VStack{
                
                Text("hello world")
                
                //                .navigationTitle("首页")
                    .navigationBarTitle("首页", displayMode: .inline)
                
                
//                    .toolbar(content: {
//                        
//                        NavigationLink(destination: 
//                            
//                        HomeView()
//                        
//                        ) {
//                            
//                            Text("搜索")
//                            
//                        }
//                    })
            }
        }
        .padding()
        .background(.white)
    }
}

#Preview {
    HomeView()
}
