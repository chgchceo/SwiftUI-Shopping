//
//  HomeView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//

import SwiftUI

struct HomeView: View {
    
    
   @State var homeModel:HomeModel?
    @State var data:[DetailModel]?
    var body: some View {
        
        
        ZStack{
            
//            //背景颜色
            Rectangle()
                .foregroundColor(Color(white: 0.9))
                
            VStack{
               
                TopView()
               
                VStack{
                    
                    Image("banner1")
                        .resizable()
                        .frame(width: .infinity,height: 200)
                    
                    Spacer()
                    
                }
                
                ScrollView {
                    
                    if let data:[DetailModel] = self.data{
                        
                        ForEach(data) { detail in
                            
                            GoodsListView(detail: detail)
                        }
                        
                    }
                }
                
                Spacer()
                
                     }
                
                    .navigationBarTitle("首页", displayMode: .inline)
                    .toolbar(content: {
                        
                        NavigationLink(destination: 
                            
                        HomeView()
                        ) {
                            Text("搜索")
                        }
                    })
        }
        .background(.white)
        .onAppear(){
            
            //加载网络数据
            initData()
            
        }
    }
    
    
   
     func initData() -> Void {
        
        
//        self.showLoadingView()
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/page/detail") { request, responseData in
            
            if let model = HomeModel.deserialize(from: responseData as? [String:Any]){
                self.homeModel = model
                self.data = model.data?.pageData?.items?[6].data
                
            }
                
            }
        }
}

struct GoodsListView:View {
   
    var detail:DetailModel?
    
    var body: some View{
        
        HStack{
            
            WebImageView(imageURL: URL(string: detail?.goods_image ?? "")!)
                .frame(width: 350,height: 350)
                .aspectRatio(contentMode: .fit)
                .clipped()
            
            
            
            VStack{
                
                
            }
        }
        
    }
}

struct TopView:View {
    
    @State private var text = "" // 使用 @State 包装器来跟踪文本变化
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 40)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .padding(.horizontal,20)
                .padding(.top,10)
                .padding(.bottom ,5)
                .foregroundColor(.white)
            HStack{
                
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                    .padding(.leading)
                TextField("请在此输入搜索关键词", text: $text)
                
            }
        }
        
        Spacer()
    }
}

#Preview {
    HomeView()
}
