
import SwiftUI



struct MineView: View {
    
    @Binding var isCurrentPage:Bool
    
    @State var isRefresh = false
    @State var isMore = false
    @State var isHasMore = true
    @State var textArr : Array<String> = []
    @State var count = 20
    
    var body: some View {
        
        NavigationView {
         
            ZStack{
                
                VStack {
                    Spacer(minLength: 100)
                    /*
                     offDown: 列表数据滑动总高
                     listH: 列表高度
                     refreshing: 下拉刷新加载UI的开关
                     isMore: 加载更多UI的开关
                     */
                    RefreshScrollView(offDown: CGFloat(textArr.count) * 40.0, listH: ScreenHeight-NavigationBarHeight-TabBarHeight, refreshing: $isRefresh, isMore: $isMore,isHasMore: $isHasMore) {
                        // 下拉刷新触发
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                            // 刷新完成，关闭刷新
                            self.loadData()
                            isRefresh = false
                            
                        })
                    } moreTrigger: {
                        // 上拉加载更多触发
                        if(isHasMore){
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                                // 加载完成，关闭加载
                                
                                
                                for i in 0...10{
                                    textArr.append(String("\(i + textArr.count) Hello, world!"))
                                }
                                
                                
                                isMore = false
                                isHasMore = false
                            })
                        }
                    } content: {
                        // 列表内容
                        
                        
                        VStack(spacing: 0){
                            Spacer()
                            ForEach(0..<(textArr.count),id: \.self) { index in
                                VStack{
                                    Text(textArr[index] ).foregroundColor(Color.red).frame(width: 200, height: 40)
                                }
                            }
                            Spacer()
                        }
                        .navigationBarTitle("个人中心", displayMode: .inline)
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
                        })).background(Color.white)
                        
                        

                        
                    }
                    
                  
                    Spacer()
            }
                .frame(width: ScreenWidth,height: ScreenHeight-NavigationBarHeight-TabBarHeight)
            }
        }
//        .navigationViewStyle(StackNavigationViewStyle()) // 使用 StackNavigationViewStyle 以获得更多自定义空间
//
//        .background(Color.white) // 给 NavigationView 添加背景颜色
        .background(Color.green.opacity(1.0).edgesIgnoringSafeArea(.all)) // 设置不透明的背景颜色
                .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            
            self.isCurrentPage = true
            //加载网络数据
            self.loadData()
            
        }
        .onDisappear(){
            
            
        }
        .padding()
    }
    
    func loadData(){
        textArr.removeAll()
        for i in 0...count{
            textArr.append(String("\(i) Hello, world!"))
        }
    }
}
