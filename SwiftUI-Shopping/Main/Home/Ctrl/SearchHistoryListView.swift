//
//  SearchHistoryListView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/1.
//

import SwiftUI

struct SearchHistoryListView: View {
    var body: some View {
        
        VStack{
            
            WebView(url: URL(string: "https://www.baidu.com")!)
                .frame(width: ScreenWidth, height: ScreenHeight)
            
        }
        .navigationTitle("商品搜索")
        
        
    }
}
