import SwiftUI
import SwiftUIRefresh // 导入 SwiftUIRefresh 库
  
struct CartView: View {
    
    @Binding var isCurrentPage:Bool
    
    @State private var isRefreshing = false
    @State private var items = ["Item 1", "Item 2", "Item 3"]
  
    var body: some View {
        
        NavigationView {
            List(items, id: \.self) { item in
                Text(item)
            }.navigationBarTitle("购物车", displayMode: .inline)
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
        
        .pullToRefresh(isShowing: $isRefreshing) {
            // 在这里执行刷新操作
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.items.insert("New Item", at: 0)
                self.isRefreshing = false
            }
        }
        .onAppear(){
            
            self.isCurrentPage = true
            //加载网络数据
            
        }
        .onDisappear(){
            
            
        }
    }
}
//
//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
