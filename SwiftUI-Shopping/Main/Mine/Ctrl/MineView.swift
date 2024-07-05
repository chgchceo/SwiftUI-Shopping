
import SwiftUI



struct MineView: View {
    
    @State var isLogin = false
    @State private var showAlert = false

    @Binding var isCurrentPage:Bool
    @State var isPushDetail = false
    @State var isRefresh = false
    @State var isMore = false
    @State var isHasMore = true
    @State var textArr : Array<String> = []
    @State var count = 20
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Rectangle()
                    .foregroundColor(bgColor)
                    .ignoresSafeArea(.all)
                
                VStack(){
                    
                    ScrollView{
                        
                        NavigationLink(destination: LoginPageView(), isActive: $isPushDetail){
                        }
                        MineTopView(isLogin: isLogin)
                            .onTapGesture {
                                self.isCurrentPage = false
                                self.isPushDetail = true
                            }
                        MineSecondView()
                        MineOrderView()
                        MineBottomView()
                        
                        if isLogin {
                            Button(action: {
                                
                                showAlert = true
                                
                                
                            }, label: {
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 1) // 设置边框颜色和宽度
                                        .foregroundColor(Color.white)
                                        .frame(width: 280,height: 40)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .padding(.top,10)
                                    
                                    Text("退出登录")
                                        .foregroundColor(Color.black)
                                        .padding(.top,10)
                                }
                                .alert(isPresented: $showAlert) {
                                           Alert(title: Text("温馨提示"), message: Text("你好，是否确定要退出登录")
                                                 , primaryButton: .default(Text("确定")) {
                                               
                                               UserDefaults.standard.set("", forKey: "userId")
                                               UserDefaults.standard.set("", forKey: "token")
                                               isLogin = false
                                               print("用户选择了退出登录")
                                               // 在这里可以添加退出登录的逻辑
                                               showAlert = false // 关闭警告框
                                           }, secondaryButton: .cancel(Text("取消")) {
                                               // 用户点击“取消”后执行的代码
                                               print("用户取消了退出登录")
                                               showAlert = false // 关闭警告框
                                           })
                                       }
                            })
                        }
                    }
                }
                .navigationTitle("个人中心")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .frame(width: ScreenWidth,height: ScreenHeight-60-TopSafeHeight-BottomSafeHeight)
                .onAppear(){
                    
                    self.isCurrentPage = true
                    //加载网络数据
                    self.loadData()
                    
                    //判断是否登录
                    isLogin = isLoginSucc()
                    
                }
                .onDisappear(){
                    
                    
                }
            }
        }
        
    }
    
    func loadData(){
        textArr.removeAll()
        for i in 0...count{
            textArr.append(String("\(i) Hello, world!"))
        }
    }
}


struct MineTopView:View {
    
    var isLogin:Bool = false
    var userId:String = (UserDefaults.standard.object(forKey: "userId") as? String) ?? ""
    
    var body: some View{
        
        HStack {
            
            Image("banner1")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: 50,height: 50)
                .cornerRadius(40)
                .padding(.leading,20)
                .padding(.trailing,5)
            Group(){
                
                if isLogin{
                    VStack {
                        Text(userId)
                            .frame(width: 100,alignment: .leading)
                            .foregroundColor(HexRGBA(0xc59a46))
                            .font(.system(size: 18).bold())
                            .padding(.bottom,5)
                            
                        
                        HStack{
                            Image(systemName: "person.2.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 13))
                            
                            Text("普通会员")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.leading ,10)
                        .frame(width: 100,height: 25,alignment: .leading)
                        .background(HexRGBA(0x3c3c3c))
                        .cornerRadius(20)
                        .padding(.bottom,3)
                    }
                    .frame(width: ScreenWidth-80,alignment: .leading)
                }else{
                    VStack {
                        Text("未登录")
                            .frame(width: 200,alignment: .leading)
                            .foregroundColor(HexRGBA(0xc59a46))
                            .font(.system(size: 18).bold())
                            .padding(.bottom,5)
                        Text("点击账号登录")
                            .frame(width: 200,alignment: .leading)
                            .padding(.bottom,5)
                            .font(.system(size: 15))
                    }
                }
            }
            
            
            Spacer()
            
        }
        .frame(width: ScreenWidth,height: 100)
    }
}

//
//struct MineView_Previews: PreviewProvider {
//   
//    
//    static var previews: some View {
//        MineView()
//    }
//}


struct MineSecondView:View {
    
    var body: some View{
        
        HStack {

            VStack {
                Text("0")
                    .frame(width: 60)
                    .foregroundColor(Color.red)
                    .font(.system(size: 18).bold())
                    .padding(.bottom,5)
                Text("账户余额")
                    .frame(width: 70)
                    .padding(.bottom,5)
                    .font(.system(size: 15))
            }
            Spacer()
            VStack {
                Text("0")
                    .frame(width: 60)
                    .foregroundColor(Color.red)
                    .font(.system(size: 18).bold())
                    .padding(.bottom,5)
                Text("积分")
                    .frame(width: 70)
                    .padding(.bottom,5)
                    .font(.system(size: 15))
            }
            Spacer()
            VStack {
                Text("0")
                    .frame(width: 60)
                    .foregroundColor(Color.red)
                    .font(.system(size: 18).bold())
                    .padding(.bottom,5)
                Text("优惠券")
                    .frame(width: 70)
                    .padding(.bottom,5)
                    .font(.system(size: 15))
            }
            
            Spacer()
            VStack {
                
                MineItemView(imgName: "drop.circle.fill",name: "我的钱包")
            }
        }
        .padding()
        .frame(width: ScreenWidth,height: 90)
        .background(Color.white)
    }
}


struct MineOrderView:View {
    
    var body: some View{
        
        HStack {

            VStack {
                
                MineItemView(imgName: "wallet.pass",name: "全部订单")
            }
            Spacer()
            VStack {
                
                MineItemView(imgName: "timer",name: "待支付")
            }
            Spacer()
            VStack {
                
               MineItemView(imgName: "box.truck.badge.clock",name: "待发货")
            }
            Spacer()
            MineItemView(imgName:"square.and.arrow.up",name: "待收货")
        }
        .padding(.horizontal,10)
        .frame(width: ScreenWidth-30,height: 80)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top,5)
    }
}

struct MineBottomView:View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let arr = ["收货地址","领券中心","优惠券","我的帮助","我的积分","退货/售后"]
    var body: some View{
        
        VStack{
           
            Text("我的服务")
                .font(.system(size: 20).bold())
                .frame(width: ScreenWidth-60,alignment:.leading)
            LazyVGrid(columns: columns) {
                
                
                ForEach(arr,id: \.self) { name in
                    MineItemView(imgName: "square.and.arrow.up",name: name,color: .red)
                        .padding(.top,10)
                }
            }
        }
        .padding()
        .frame(width: ScreenWidth-30)
        .background(Color.white)
        .cornerRadius(15)
        .padding(.top,5)
    }
}


struct MineItemView:View {
    
    var imgName:String?
    var name:String?
    var color:Color = Color.black
    var body: some View{
        
        VStack {
            
            Image(systemName: imgName ?? "")
                .frame(width: 60)
                .font(.system(size: 18).bold())
                .padding(.bottom,5)
                .foregroundColor(color)
            Text(name ?? "")
                .frame(width: 70)
                .padding(.bottom,5)
                .font(.system(size: 15))
        }
    }
}
