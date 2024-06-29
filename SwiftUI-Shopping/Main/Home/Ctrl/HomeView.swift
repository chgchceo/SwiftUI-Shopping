//
//  HomeView.swift
//  SwiftUI-Shopping
//
//  Created by cheng on 2024/6/27.
//

import SwiftUI
import URLImage

struct HomeView: View {

    @Binding var isCurrentPage:Bool
    @State private var showDetail = false

    @State var page:Int = 1 //页数
    @State var isRefresh = false //下拉刷新
    @State var isMore = false //加载更多
    @State var isHasMore = false //是否加载完成

    @State private var isLoading = false

   @State var homeModel:HomeModel?
    @State var data:[DetailModel]?
    var body: some View {

        NavigationView {

            ZStack{

    //            //背景颜色
                Rectangle()
                    .foregroundColor(Color(white: 0.9))

                VStack{

                    TopView()

                    RefreshScrollView(offDown: CGFloat(self.data?.count ?? 0) * 200.0 + 200, listH: ScreenH - kNavHeight - kBottomSafeHeight, refreshing: $isRefresh, isMore: $isMore,isHasMore: $isHasMore) {
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


                            Image("banner1")
                                .resizable()
                                .frame(width: ScreenWidth,height: 200)
                            if let data:[DetailModel] = self.data{

                                ForEach(data) { detail in


                                        GoodsListView(detail: detail)
                                            .onTapGesture {

                                                //收起键盘，防止意外情况
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                                                self.isCurrentPage = false

                                                self.showDetail = true
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

                if isLoading {

                    LoadingView()
                }

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
    }



     func initData() -> Void {

        self.isLoading = true
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/page/detail") { request, responseData in

            if let model = HomeModel.deserialize(from: responseData as? [String:Any]){
                self.homeModel = model
                self.data = model.data?.pageData?.items?[6].data

            }
            self.isLoading = false
            self.isRefresh = false
            self.isMore = false
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

//#Preview {
//    HomeView()
//}
