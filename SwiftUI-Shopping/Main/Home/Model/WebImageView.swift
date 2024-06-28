//
//  WebImageView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/28.
//

import SwiftUI
import SDWebImage
  
struct WebImageView: UIViewRepresentable {
    var imageURL: URL
  
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.sd_setImage(with: imageURL) { (image, error, cacheType, url) in
            // 你可以在这里处理加载完成或失败的情况
            
            imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        }
        imageView.contentMode = .scaleAspectFit
        // 根据需要设置内容模式
        imageView.clipsToBounds = true
        return imageView
    }
  
    func updateUIView(_ uiView: UIImageView, context: Context) {
        // 在这里更新 UI 如果需要的话，但在这个例子中我们不需要
        
        
    }
    
    func refresh(frame:CGRect) -> Void {
        
        
    }
}
