//
//  HomeView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//

import SwiftUI
import URLImage

struct HomeView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var showAlert = false

    @Binding var isCurrentPage:Bool
    @State private var showDetail = false
    @State private var showSearchList = false

    @State var page:Int = 1 //页数
    @State var isRefresh = false //下拉刷新
    @State var isMore = false //加载更多
    @State var isHasMore = false //是否加载完成

    @State private var isLoading = false

   @State var homeModel:HomeModel?
    @State var data:[DetailModel]?
    @State var imgUrls:[DetailModel]?
    @State var cateArr:[DetailModel]?

    var body: some View {

        NavigationView {

            ZStack{
                
                
                
    //            //背景颜色
                Rectangle()
                    .foregroundColor(Color(white: 0.9))

                VStack(spacing: 0){
                    
                    NavigationLink(
                        destination: SearchHistoryListView(),
                        isActive: $showSearchList,
                        label: {
                            
                        })


                    TopSearchView().onTapGesture {
                        self.isCurrentPage = false
                        self.showSearchList = true
                    }

                    RefreshScrollView(offDown: CGFloat(self.data?.count ?? 0) * 220.0 + 200, listH: ScreenH - kNavHeight - kBottomSafeHeight, refreshing: $isRefresh, isMore: $isMore,isHasMore: $isHasMore) {
                        // 下拉刷新触发
                        self.page = 1
                        self.initData()
                    } moreTrigger: {
                        // 上拉加载更多触发
                        if(isHasMore){
                            self.page += 1
                            self.initData()
                        }
                    } content: {
                        ScrollView {
                            
                            if imgUrls?.count ?? 0 > 0{
                                
                                BannerView(imageUrls: imgUrls, isCurrentPage: $isCurrentPage)
                                
                            }

                            if cateArr?.count ?? 0 > 0{
                                
                                LazyVGrid(columns: columns, spacing: 1) {
                                    
                                   
                                    ForEach(self.cateArr!) { detail in
                                        
                                        VStack{
                                            Spacer()
                                            URLImage(URL(string: detail.imgUrl ?? "")!, placeholder: Image("categood")){
                                                
                                                image in
                                                
                                                image
                                                    .image.resizable()
                                                    .aspectRatio(contentMode: .fit)
                                            }
                                                .frame(width: 30 ,height: 30)
                                                
                                            Spacer()
                                            Text(detail.text!)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                            Spacer()
                                        }
                                        
                                    }   .frame(width: ScreenWidth/5.0, height: 80)
                                        .background(Color.white)
                                        .cornerRadius(0)
                                    
                                }
                                                
                                       
                            }

                            if let data:[DetailModel] = self.data{

                                ForEach(data) { detail in


                                        GoodsListView(detail: detail)
                                            .onTapGesture {

                                                //收起键盘，防止意外情况
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                                                self.isCurrentPage = false

                                                self.showDetail = true
                                    }

                                    NavigationLink(destination: GoodsDetailPageView(goodsId: detail.goods_id ?? ""),isActive: $showDetail){
                                        if #available(iOS 16.0, *) {
                                            EmptyView()
                                                .backgroundStyle(.red)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    }
                                }
                            }
                        }
                    }

//                    Spacer()

                }.padding(0)

                        .navigationBarTitle("首页", displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {

                            self.showAlert = true
                            print("ss")
                        }, label: {
                            Text("搜索")
                                .foregroundColor(.black)
                        }),trailing: Button(action: {

                            self.showAlert = true
                            print("sz")
                        }, label: {
                            Text("设置")
                                .foregroundColor(.red)
                        })
                            
                        
                        )

                if isLoading {

                    LoadingView()
                }

            }
            .alert(isPresented: $showAlert) {
                       Alert(title: Text("温馨提示"), message: Text("你好，是否确定要退出登录")
                             , primaryButton: .default(Text("确定")) {
                           // 用户点击“确定”后执行的代码
                           print("用户选择了退出登录")
                           // 在这里可以添加退出登录的逻辑
                           showAlert = false // 关闭警告框
                       }, secondaryButton: .cancel(Text("取消")) {
                           // 用户点击“取消”后执行的代码
                           print("用户取消了退出登录")
                           showAlert = false // 关闭警告框
                       })
                   }
            .onAppear(){

                //加载网络数据
                if(self.isCurrentPage){
                    
                    initData()
                    
                }

                self.isCurrentPage = true
            }
            .onDisappear(){

            }

        }
//        .alert(isPresented: $showAlert) {
//                   Alert(title: Text("Alert"), message: Text("This is an alert in NavigationView!"), dismissButton: .default(Text("OK")))
//               }
    }



     func initData() -> Void {

        self.isLoading = true
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/page/detail") { request, responseData in

            if let model = HomeModel.deserialize(from: responseData as? [String:Any]){
                self.homeModel = model
                self.data = model.data?.pageData?.items?[6].data
                self.imgUrls = model.data?.pageData?.items?[1].data
                self.cateArr = model.data?.pageData?.items?[3].data
                
            }
            self.isLoading = false
            self.isRefresh = false
            self.isMore = false
        }
    }
}



//#Preview {
//    HomeView()
//}
