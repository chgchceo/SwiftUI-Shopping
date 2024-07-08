//
//  GoodsDetailPageView.swift
//  SwiftUI-Shopping
//
//  Created by 程广成 on 2024/6/29.
//

import SwiftUI
import URLImage

struct GoodsDetailPageView: View {
    
    //是否返回到第一页
    @Binding var firstShowDetail:Bool
    
    @State var showCartView = false
    
    @Binding var showDetail2:Bool

     var goodsId:String = ""
    
    @State var detail:GoodsDetailData?
    
    @State var bannerData:[GoodsImageModel]?
    
    @State var comData:[GoodsCommentDetailData]?
    
    @State var total = "0"
    
    var body: some View {
        
        ZStack{
            VStack{
                
                ScrollView {
                    
                    VStack{
                        
                        //banner
                        if self.bannerData != nil{
                            
                            GoodsDetailBannerView(imageUrls: self.bannerData)
                        }
                        
                        //price
                        HStack{
                            
                            
                            Text("¥\(detail?.goods_price_min ?? "")")
                                .font(.system(size: 18).bold())
                                .foregroundColor(.red)
                            
                            Text(detail?.goods_price_max ?? "")
                                .strikethrough()
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            Text("已售\(detail?.goods_sales ?? "0")件")
                                .foregroundColor(.gray)
                            
                        }
                        .padding(.horizontal,15)
                        .padding(.vertical,10)
                        
                        Text(detail?.goods_name ?? "")
                            .padding(.horizontal,10)
                        
                        HStack{
                            
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.red)
                            Text("七天无理由退货")
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.red)
                            Text("48小时发货")
                            Spacer()
                            Image(systemName: "chevron.forward")
                            
                        }
                        .padding(10)
                        .background(bgColor)
                        .cornerRadius(5)
                        .frame(width: ScreenWidth-20)
                        
                        HStack{
                            
                            Text("商品评价(\(self.total)条)")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                            Spacer()
                            HStack{
                                
                                Text("查看更多")
                                    
                                Image(systemName: "chevron.forward")
                                    .padding(.trailing,10)
                                
                            }
                            .foregroundColor(.gray)
                        }
                        .padding(10)
                        
                    }
                    
                    //评论列表
                    if let c = comData{
                        ForEach(c){ d in
                            
                            CommentListView(detail: d)
                        }
                        
                    }
                    
                    if self.detail?.content.count ?? 0 > 0{
                        
                        //图片详细
                        WebView(htmlStr:self.detail?.content ?? "")
                            .frame(maxWidth: ScreenWidth,minHeight: ScreenHeight,maxHeight:20000)
                    }
                    VStack{
                        
                    }
                    .frame(height: 100)
                    .background(Color.white)
                }
                .frame(width: ScreenWidth, height: ScreenHeight-NavigationBarHeight-BottomSafeHeight)
            }
            
            BottomFixView(showDe: $showDetail2, showCart: $showCartView, firstShowDetail: $firstShowDetail)
            
            if showCartView {
                
                SwiftUIAlertView(detail: self.detail, showView: $showCartView)
            }
        }
        .frame(width: ScreenWidth,height: ScreenHeight-NavigationBarHeight-BottomSafeHeight)
        
        .navigationTitle("商品详情页")
        .onAppear(){
            
            self.initData()
            self.initCommentData()
        }
        .onDisappear(){
            
            
        }
    }
    //评论数据
    func initCommentData() -> Void {
        
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/comment/listRows&goodsId=\(goodsId)&limit=3") { request, responseData in
            
          let model =  GoodsCommentListData.deserialize(from: responseData as? Dictionary<String, Any>)
            if model?.status == 200{
                
                self.comData = model?.data?.list
                self.total = model?.data?.total ?? "0"
            }
        }
    }
    
    func initData() -> Void {
        
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/goods/detail&goodsId=\(goodsId)") { request, responseData in
            
          let model =  GoodsDetailPageModel.deserialize(from: responseData as? Dictionary<String, Any>)
            if model?.status == 200{
                
                self.detail = model?.data?.detail
                self.bannerData = model?.data?.detail?.goods_images
                
            }
        }
    }
    
}

//底部固定视图
struct BottomFixView:View {
    
    @Binding var showDe:Bool
    @Binding var showCart:Bool
    //是否返回到第一页
    @Binding var firstShowDetail:Bool

    @State private var isPresented = false
    
    var body: some View{
        
        VStack{
            Spacer()
            VStack{
                Divider()
                HStack{
                    
                    VStack{
                        
                        Image(systemName: "homekit")
                            .font(.system(size: 16))
                            
                        Text("首页")
                            .font(.system(size: 16))
                    }
                    .onTapGesture {
                        
                        showDe = false
                        firstShowDetail = false
                    }
                    .padding(.leading,8)
                    VStack{
                        Image(systemName: "cart")
                            .font(.system(size: 16))
                        Text("购物车")
                            .font(.system(size: 16))
                    }
                    Spacer()
                    Button(action: {
                        
//                        isPresented = true
                        showCart = true
                        
                    }, label: {
                        Text("加入购物车")
                            .frame(width: 120,height: 36)
                            .background(Color.orange)
                            .cornerRadius(18)
                            .foregroundColor(.white)
                        
                    })
                    .fullScreenCover(isPresented: $isPresented, content: {
                        
                        VStack{
                            Text("这是一个模态视图！")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Button {
                                
                                isPresented = false
                            } label: {
                                
                                Text("关闭")
                            }
                        }
                        .background(Color.red)
                    }
                    )
//                    .sheet(isPresented: $isPresented) {
//                               // 这里定义要展示的模态视图
//                               Text("这是一个模态视图！")
//                                   .padding()
//                                   .background(Color.blue)
//                                   .foregroundColor(.white)
//                                   .cornerRadius(10)
//                                   // 可以在这里添加按钮或操作来关闭模态视图
////                                   button(action: {
////                                       // 关闭模态视图
////                                       isPresented = false
////                                   }) {
////                                       Text("关闭")
////                                   }
//                           }
                    Button(action: {
                        
                        
                    }, label: {
                        Text("立即购买")
                            .frame(width: 120,height: 36)
                            .background(Color.red)
                            .cornerRadius(18)
                            .foregroundColor(.white)
                            .padding(.trailing,8)
                    })
                    
                }
                .frame(width: ScreenWidth,height: 55)
                
                

            }
            .background(Color.white)
        }
    }
}

struct CommentListView:View {
    
    var detail:GoodsCommentDetailData?
    
    var body: some View{
        
        VStack{
            
            if let data = detail{
                
                HStack{
                    
                    Image("default-avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 25)
                        .cornerRadius(12.5)
                    
                    
                    Text(data.user?.nick_name ?? "")
                        .frame(width: ScreenWidth-50,alignment: .leading)
                    
                }
                
                Text(data.content)
                    .frame(width: ScreenWidth-30,alignment: .leading)
                    .padding(5)
                
                Text(data.create_time)
                    .frame(width: ScreenWidth-30,alignment: .leading)
                    .foregroundColor(.gray)
                    .padding(5)
            }
        }
        .frame(width: ScreenWidth-30)
        
    }
}


//{
//
//    @State private var isPresented = false
//
//       var body: some View {
//           ZStack {
//               // 背景视图，可以是你的主视图或其他内容
//               Color.green.edgesIgnoringSafeArea(.all)
//               // 按钮用于触发弹出视图
//               Button("显示弹出视图") {
//                   isPresented = true
//               }
//               .padding()
//
//               Text("hehe")
//                   .frame(width: ScreenWidth)
//                   .multilineTextAlignment(.leading)
//                   .background(Color.red)
//
//               // 弹出视图，这里使用了一个简单的VStack作为示例
//               if isPresented {
//                   VStack {
//
//                       Text("这是一个从底部弹出的视图")
//                           .padding()
//                           .background(Color.blue)
//                           .cornerRadius(10)
//                           .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
//
//                       Spacer()
//
//                       Button("关闭") {
//                           isPresented = false
//                       }
//                       .padding()
//                       .background(Color.red)
//                       .foregroundColor(.white)
//                   }
//                   .frame(width: ScreenWidth)
//                   .background(Color.gray.opacity(0.9))
//
//                   .ignoresSafeArea(.all)
//                   .frame(maxWidth: .infinity, maxHeight: ScreenHeight)
//                   .background(Color.clear) // 自定义背景透明度
//                   .transition(.move(edge: .bottom)) // 动画效果
//                   .offset(y: isPresented ? 0 : UIScreen.main.bounds.height) // 初始位置在屏幕外
//                   .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2))
//               }
//
//
//           }
//       }
//
//}
