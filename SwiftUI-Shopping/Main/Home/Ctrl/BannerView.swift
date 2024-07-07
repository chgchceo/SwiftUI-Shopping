//
//  BannerView.swift
//  SwiftUI-Shopping
//
//  Created by 程广成 on 2024/6/30.
//


import SwiftUI
import ACarousel // 假设这是轮播图库的导入语句
import URLImage
  
struct BannerView:View {
    
    var imageUrls:[DetailModel]?
    @Binding var isCurrentPage:Bool
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
                
                URLImage(URL(string: detail.imgUrl ?? "")!, placeholder: Image("banner1")){
                    
                    image in
                    
                    image
                        .image.resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.frame(height: 200)
            
            
            VStack{
                
                Spacer()
                // 页码视图
                PageControl(numberOfPages: 3, currentPage: $currentPage)
                               .padding(.bottom, 20)
                               
                
            }
        }.onTapGesture {
        
            self.isCurrentPage = false
            self.showDetail = true
            print("\(currentPage)")
        }
//        NavigationLink(destination: GoodsDetailPageView(),isActive: $showDetail){
//            if #available(iOS 16.0, *) {
//                EmptyView()
//                    .backgroundStyle(.red)
//            } else {
//                // Fallback on earlier versions
//            }
//        }
    }
}


struct PageControl: View {
    var numberOfPages: Int = 0
    @Binding var currentPage: Int
      
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages) { index in

                Group {
                    
                    if index == currentPage {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(width: 20, height: 10)
                    }else{
                        
                        Circle()
                            .fill(Color(white: 0.8))
                            .frame(width: 10, height: 10)
                        
                    }
                }
            }
        }
    }
}

