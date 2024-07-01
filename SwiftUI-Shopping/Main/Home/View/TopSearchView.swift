//
//  TopSearchView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/1.
//

import SwiftUI

struct TopSearchView: View {
    
    @State private var text = "" // 使用 @State 包装器来跟踪文本变化
    var body: some View {

        ZStack{

            RoundedRectangle(cornerRadius: 40)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.horizontal,20)
                .padding(.top,10)
                .padding(.bottom ,10)
                .foregroundColor(.white)
            HStack{

                Image(systemName: "magnifyingglass")
                    .padding(.leading,35)
                    .foregroundColor(.gray)
                TextField("请在此输入搜索关键词", text: $text)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)

                Spacer()
            }
        }
        .background(Color(white: 0.9))

        Spacer()
    }
}
