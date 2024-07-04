//
//  ToastView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/4.
//

import SwiftUI
    struct ToastView: View {
        
        @Binding var isVisible: Bool
        let message: String
      
        var body: some View {
            ZStack {
                if isVisible {
                    VStack {
                        Text(message)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, maxHeight: 50) // 限制Toast的高度
                            .padding(.top, 20) // 距离屏幕顶部的距离
                            .animation(.easeInOut(duration: 0.5), value: isVisible)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                // 假设ToastView的父视图有一个方法来更新isVisible状态
                                // 这里我们使用@Binding来直接修改isVisible
                                isVisible = false
                            }
                        }
                    }
                }
            }
        }
}
  
