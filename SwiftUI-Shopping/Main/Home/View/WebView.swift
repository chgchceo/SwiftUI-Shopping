//
//  WebView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/5.

import SwiftUI
import WebKit
  
struct WebView: UIViewRepresentable {
    var url: URL?
    var htmlStr:String?
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.uiDelegate = context.coordinator as? any WKUIDelegate
        
        if url?.absoluteString.count ?? 0 > 0{

            let request = URLRequest(url: url!)
            webView.load(request)

        }
        
        if htmlStr?.count ?? 0 > 0{
            
            webView.loadHTMLString(htmlStr!, baseURL: nil)
        }
        
        return webView
    }
  
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 这里可以处理任何 UI 更新，但在这个例子中，我们不需要在视图更新时做任何特别的事情
    }
  
    // Coordinator 用于处理 WKNavigationDelegate 方法
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
  
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 页面加载完成后的处理
        }
  
        // 你可以在这里添加更多 WKNavigationDelegate 方法
    }
}
