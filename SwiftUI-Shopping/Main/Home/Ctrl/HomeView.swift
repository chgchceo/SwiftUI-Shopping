//
//  HomeView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//

import SwiftUI
import URLImage

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
               
                ScrollView {
                    
                        
                   Image("banner1")
                            .resizable()
                            .frame(width: .infinity,height: 200)
                        
                    if let data:[DetailModel] = self.data{
                        
                        ForEach(data) { detail in
                            
                            GoodsListView(detail: detail)
                        }
                        
                    }
                }
                
                Spacer()
                
                     }
                
                    .navigationBarTitle("首页", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        
                        print("ss")
                    }, label: {
                        Text("搜索")
                            .foregroundColor(.black)
                    }),trailing: Button(action: {
                        
                        print("sz")
                    }, label: {
                        Text("设置")
                            .foregroundColor(.red)
                    }))
        }
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
          
            HStack{
                
                // 假设你有一个图片的URL
                let imageURL = URL(string: detail?.goods_image ?? "")!
                URLImage(imageURL, placeholder: Image("logo")){
                    
                    image in
                    
                    image
                        .image.resizable()
                        .aspectRatio(contentMode: .fit)
                }
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
            }
            
            VStack(alignment: .leading, spacing: 10){
                
                Text(detail?.goods_name ?? "")
                    
                
                Text("销售量:\(detail?.goods_sales ?? "")")
                
                HStack{
                    
                    Text(detail?.goods_price_min ?? "")
                        .foregroundColor(Color.red)
                        .font(.system(size:20))
                        .fontWeight(Font.Weight.bold)
                    Text(detail?.goods_price_max ?? "")
                        .foregroundColor(Color.gray)
                        .font(.system(size:16))
                        .strikethrough()
                    
                }
                
            }.padding(.leading,10)
        }.padding(15)

            .background(Color.white)
        
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

//#Preview {
//    HomeView()
//}
