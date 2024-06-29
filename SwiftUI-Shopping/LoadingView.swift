//
//  LoadingView.swift
//  SwiftUI-Shopping
//
//  Created by 程广成 on 2024/6/29.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.1))
                
            VStack{
                
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    
                Spacer()
                Text("正在加载")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                Spacer()
            }
        }.frame(width: 100,height: 100)
    }
}


