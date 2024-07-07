//
//  SearchGoodsListView.swift
//  SwiftUI-Shopping
//
//  Created by 程广成 on 2024/7/6.
//

import SwiftUI

struct SearchGoodsListView: View {
    @State private var isLoading = false
    @State var page:Int = 1 //页数
    @State var isRefresh = false //下拉刷新
    @State var isMore = false //加载更多
    @State var isHasMore = true //是否加载完成
    
    @State var key:String = ""
    
    @State var sortType:String = "all"
    @State var sortPrice:String = "0"
    @State var categoryId:String = ""
    
    @State var hasData = true
    
    @State private var showDetail = false
    
    @State var goodsId = ""
    
    @State var data:[DetailModel]?
    
    var body: some View {
        
        ZStack{
            
            bgColor
            
            VStack{
                
                HStack{
                    
                    TextField("请输入搜索关键字", text: $key)
                }
                .padding()
                .frame(width: ScreenWidth-30,height: 50)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                
                HStack{
                    Spacer()
                    Button {
                        leftButtAc()
                    } label: {
                        Text("综合")
                    }
                    Spacer()
                    Button {
                        centerButtAc()
                    } label: {
                        Text("销量")
                    }
                    Spacer()
                    Button {
                        rightButtAc()
                    } label: {
                        Text("价格")
                    }
                    Spacer()
                }
                .foregroundColor(.gray)
                .font(.system(size: 19))
                
                RefreshScrollView(offDown: CGFloat(self.data?.count ?? 0) * 220.0, listH: ScreenH - kNavHeight - kBottomSafeHeight-100, refreshing: $isRefresh, isMore: $isMore,isHasMore: $isHasMore) {
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

                        if let data:[DetailModel] = self.data{

                            ForEach(data) { detail in

                                    GoodsListView(detail: detail)
                                        .onTapGesture {

                                            //收起键盘，防止意外情况
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                                            self.goodsId = detail.goods_id ?? ""
                                            self.showDetail = true
                                }

                                NavigationLink(destination: GoodsDetailPageView(showDetail2: $showDetail, goodsId: self.goodsId),isActive: $showDetail){
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
            }
            
            if hasData == false{
                
                Text("暂无数据")
                
            }
            if isLoading {

                LoadingView()
            }
        }
        .onAppear(){
            
            self.initData()
        }
        .navigationTitle("商品列表")
    }
    
    func initData() -> Void {
        
        let param:[String:Any] = [
        
            "page":self.page,
            "categoryId":self.categoryId,
            "sortType":self.sortType,
            "sortPrice":self.sortPrice,
            "goodsName":self.key
        ]
        isLoading = true
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/goods/list",parameters: param) { request, responseData in
            
            let model:GoodsListModel = GoodsListModel.deserialize(from: responseData as? [String:Any]) ?? GoodsListModel()
            self.isRefresh = false
            self.isMore = false
            isLoading = false
            if model.status == 200 {
                
                let data = model.data?.list?.data
                
                if self.page == 1{
                    
                    self.data = data
                }else{
                    
                    self.data?.append(contentsOf: data ?? [])
                }
                if (data?.count ?? 0 < 15){
                    
                    self.isHasMore = false
                }
                
                if (self.data?.count ?? 0 <= 0){
                    
                    hasData = false
                }
            }
        }
        
    }

     func leftButtAc() {
        self.page = 1
        self.sortType = "all"
        self.initData()
    }
    
     func centerButtAc() {
        self.page = 1
        self.sortType = "sales"
        self.initData()
    }
    
     func rightButtAc() {
        self.page = 1
        self.sortType = "price"
        self.initData()
    }
    
}


//struct SearchGoodsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchGoodsListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

