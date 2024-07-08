
import SwiftUI
import URLImage

struct CategoryView: View {
    
    
    @State var showDetail = false
    
    @State var cagegoryId = ""
    
    @State var selIndex = 1
    @State private var isLoading = false
    
    @Binding var isCurrentPage:Bool
    
    @State var data:[CategoryDetailData]?
    
    @State var rightData:[CategoryChildrenData]?
    
    @State var selDetail:CategoryDetailData?
  
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
      
    var body: some View {
        
        NavigationView {
            
            ZStack{
                VStack(spacing: 0) {
                    
                    TopSearchView()
                           
                    NavigationLink(destination: SearchGoodsListView(firstShowDetail: $showDetail, categoryId: cagegoryId),isActive: $showDetail) {
                        
                    }
                    HStack(spacing: 0){
                        
                        ScrollView {
                            
                                
                                VStack(spacing: 0){
                                    
                                    if let data = self.data, data.count > 0 {
                                        ForEach(self.data!) { (detail) in
                                            
                                            ZStack{
                                                
                                                
                                                Text(detail.name)
                                                    .frame(width: 100, height: 45)
                                                    
                                                    .padding(0)
                                                    .font(.system(size: 14))
                                                    .onTapGesture {
                                                        
                                                        
                                                        for d in self.data! {
                                                            d.bColor = bgColor
                                                        }
                                                        
                                                        self.selDetail = detail
                                                        detail.bColor = Color.white
                                                        self.rightData = detail.children // 假设 detail 有一个 children 属性
                                                    }
                                                    .background(detail.bColor)
                                            }
                                            
                                        }
                                    }

                            }
                            
                        }
                        .padding(0)
                        Spacer()
                        
                        ScrollView{
                           
                            //右侧视图
                            LazyVGrid(columns: columns, content: {
                                
                                if let data = self.rightData, data.count > 0 {
                                    ForEach(self.rightData!) { (detail) in
                                        
                                        VStack{
                                            
                                            URLImage(URL(string: detail.image!.preview_url)!){ image in
                                                
                                                image
                                                    .image.resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 60, height: 100, alignment: .center)
                                            }

                                            
                                            Text(detail.name)
                                                .frame(width: 100, height: 45)
                                                
                                                .padding(0)
                                                .font(.system(size: 14))
                                                .onTapGesture {
                                                    
                                                }
                                        }.onTapGesture {
                                        
                                           cagegoryId = detail.category_id
                                           showDetail = true
                                            isCurrentPage = false
                                        }
                                        
                                    }
                                }
                                
                                
                            })
                            .frame(width:(ScreenWidth-100))

                        }
                        
                    }
                    
                }.navigationBarTitle("分类", displayMode: .inline)
                    .padding(0)
                    .onAppear(){
                        
                        //加载网络数据
                        if(self.isCurrentPage){
                            
                            initData()
                            
                        }

                        self.isCurrentPage = true
                        
                    }
                    .onDisappear(){
                        
                        
                    }
                
                if isLoading {

                    LoadingView()
                }
                
            }
            
        }.padding(0)
        
        
    }
    
     func initData() -> Void {
        
        self.isLoading = true
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/category/list") { request, responseData in

            if let model = CategoryModel.deserialize(from: responseData as? [String:Any]){
                
                if model.status == 200 {
                    
                    self.data = model.data?.list
                    
                    if self.data?.isEmpty == false{
                       
                        let first:CategoryDetailData = (model.data?.list?.first)!
                        
                        self.rightData = first.children
                        
                    }
                }
            }
            self.isLoading = false
            
        }
    }
}
