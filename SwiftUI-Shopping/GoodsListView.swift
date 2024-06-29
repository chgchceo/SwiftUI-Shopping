//
//  GoodsListView.swift
//  SwiftUI-Shopping
//
//  Created by 程广成 on 2024/6/29.
//

import SwiftUI
import URLImage

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

            .frame(height: 200)
            .background(Color.white)
    }
    
}
