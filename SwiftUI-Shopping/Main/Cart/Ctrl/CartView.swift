import SwiftUI
import URLImage
import SwiftUIRefresh // 导入 SwiftUIRefresh 库
  
struct CartView: View {
    
    let changeTab:(Int) ->Void
    
    @State var data:[CartDetailData]?
    @Binding var isCurrentPage:Bool
    
    @State private var items = ["Item 1", "Item 2", "Item 3","Item 1", "Item 2", "Item 3"]
  
    var body: some View {
        
        NavigationView {

            VStack{
                
                if isLoginSucc(){//已登录状态
                    VStack{
                    TopView()
                    ScrollView {
                        VStack{
                            
                            if let data = self.data{
                                
                                ForEach(data) { detail in
                                    
                                    MiddleView(detail: detail)
                                }
                            }
                        }
                    }
                    .frame(height: ScreenHeight-TabBarHeight-NavigationBarHeight-90-BottomSafeHeight)
                    
                    BottomView()
                    ThickDivider(color: bgColor, thickness: 0.5)
                    
                }.background(bgColor)
                }else {//未登录
                    
                    VStack{
                        Image("empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140,height: 92)
                            
                        
                        Text("您的购物车空空如也，快去逛逛吧！")
                            .padding(30)
                            .foregroundColor(.gray)
                        
                        Button {
                            
                            changeTab(0)
                        } label: {
                            
                            Text("去逛逛")
                                .frame(width: 110,height:32)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                    }
                    .background(Color.white)
                }
                
            }
            
            .padding(0)
            .navigationBarTitle("购物车", displayMode: .inline)
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
            
            self.isCurrentPage = true
            initData()
        }
        .onDisappear(){
            
            
        }
    }
    
    func initData() -> Void {
        
        self.data = nil
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/cart/list") { request, responseData in
            
          let model =  CartListModel.deserialize(from: responseData as! Dictionary<String, Any> as Dictionary)
            if model?.status == 200{
                
                self.data = model?.data?.list
            }
        }
    }
}

struct TopView:View {
    
    var num:Int = 0
    var body: some View {
        
        HStack(spacing: 0){
            
            Text("共")
                .padding(.leading,15)
            Text("\(num)")
                .foregroundColor(.red)
            Text("商品")
            
            Spacer()
            
            HStack{
                Image(systemName: "pencil")
                Text("编辑")
            }.onTapGesture {
                
                print("edit")
            }
            .padding(.trailing,15)
        }
        .frame(height: 40)
    }
}

struct MiddleView:View {
    
    var detail:CartDetailData?
    
    var body: some View{
        
        ZStack{
            
            HStack{
                
                
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                                .padding(.leading,5)
                                .font(.system(size: 20))
                
                URLImage(URL(string: (detail?.goods!.goods_image)!)!){ image in
                    
                    image
                        .image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120,height: 120)
                        .cornerRadius(20)
                        .clipped()
                        .padding(.vertical,20)
                }
                
                            VStack{
                                
                                Text((detail?.goods!.goods_name)!)
                                    .padding(10)
                                    .frame(width: 200,alignment: .leading)
                                    .lineLimit(4)
                                    .font(.system(size: 14))
                                
                                HStack{
                                    
                                    Text((detail?.goods!.goods_price_min)!)
                                        .foregroundColor(.red)
                                    
                                    Text("-")
                                    
                                    .frame(width: 20,height: 30)
                                    .background(bgColor)
                                    Text(detail!.goods_num)
                                        .frame(width: 40,height: 30)
                                        .background(bgColor)
                                        .padding(.horizontal,1)
                                    Text("+")
                                        .frame(width: 20,height: 30)
                                        .background(bgColor)
                                }
                                .padding(.bottom,15)
                            }
                        }
        }
        .padding(5)
        .background(Color.white)
        .frame(minWidth: ScreenWidth-30,maxWidth: ScreenWidth-30)
        .cornerRadius(20)
    }
}


struct BottomView:View {
    
    var body: some View{
        
        HStack{
            
            HStack{
                
                Button(action: {}, label: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 20))
                    Text("全选")
                    
                    Spacer()
                })
                .padding(.leading,15)
                Spacer()
                Text("合计：¥")
                
                Text("9999.00")
                    .foregroundColor(.red)
                
                Button(action: {}, label: {
                    Text("结算(5)")
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 36)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(18)
                    
                })
                .padding(.trailing,15)
            }
            
        }
        .frame(height: 50)
        .background(Color.white)
    }
}

struct ThickDivider: View {
    let color: Color
    let thickness: CGFloat
  
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: thickness) // 设置分割线的厚度
    }
}

