//
//  GoodsDetailBannerView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/7/5.
//

import SwiftUI
import ACarousel // 假设这是轮播图库的导入语句
import URLImage
  
struct GoodsDetailBannerView:View {
    
    var imageUrls:[GoodsImageModel]?
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentPage = 0
    @State private var showDetail = false
    var body: some View {
        
        ZStack {
            
            ACarousel(imageUrls ?? [],index: $currentPage, spacing: 0,
                      headspace: 0,
                      sidesScaling: 0.8,
                      isWrap: true,
                      autoScroll: .active(5)) { detail in
                
                URLImage(URL(string: detail.preview_url )!, placeholder: Image("banner1")){
                    
                    image in
                    
                    image
                        .image.resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            
            
            VStack{
                
                Spacer()
                // 页码视图
                PageControl(numberOfPages: imageUrls?.count ?? 0, currentPage: $currentPage)
                               .padding(.bottom, 20)
                               
                
            }
        }
        .frame(height: 300)
        .onTapGesture {
        
        }
        NavigationLink(destination: GoodsDetailPageView(),isActive: $showDetail){
            if #available(iOS 16.0, *) {
                EmptyView()
                    .backgroundStyle(.red)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

